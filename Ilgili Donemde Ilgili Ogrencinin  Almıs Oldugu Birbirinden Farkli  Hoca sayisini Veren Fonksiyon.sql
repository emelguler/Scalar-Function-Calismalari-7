USE [Okul]


--Ilgili Donemde Ilgili Ogrencinin  Almıs Oldugu Birbirinden Farkli  Hoca sayisini Veren Fonksiyon:

ALTER FUNCTION [dbo].[FN$OgrencininAldigiHocaSayisi](@Ogrenci_Id int,@Donem_Id int)
returns int
as
begin
declare @sonuc as int


set  @sonuc = (select  count(*) 
from

(select o.Id as Ogrenci_Id, o.Adi+' '+o.SoyAdi as adisoyadi, 
og.Ogretmen_Id,do.Adi as dönemadi
from dbo.OgrenciOgretmenDers as ood
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.OgretmenDers  as og on og.Id=ood.OgretmenDers_Id
inner join dbo.Ders as d on d.Id=og.Ders_Id and d.Statu=1
inner join dbo.Donem as do on do.Id=og.Donem_Id and do.Statu=1
inner join dbo.Ogretmen as ogt on ogt.Id=og.Ogretmen_Id and ogt.Statu=1
where ood.Statu=1
and og.Donem_Id = 1
and o.Id = @Ogrenci_Id
and do.Id = @Donem_Id
group by o.Id,og.Ogretmen_Id,o.Adi,o.SoyAdi,do.Adi
)B
group by b.Ogrenci_Id,b.adisoyadi,b.dönemadi)

return @sonuc
end




--cagiralim:
select [dbo].[FN$OgrencininAldigiHocaSayisi](6,1)




--where clause kontrolu:
select  count(*) from
(select o.Id as Ogrenci_Id, o.Adi+' '+o.SoyAdi as adisoyadi, 
og.Ogretmen_Id,do.Adi as dönemadi
from dbo.OgrenciOgretmenDers as ood
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.OgretmenDers  as og on og.Id=ood.OgretmenDers_Id
inner join dbo.Ders as d on d.Id=og.Ders_Id and d.Statu=1
inner join dbo.Donem as do on do.Id=og.Donem_Id and do.Statu=1
inner join dbo.Ogretmen as ogt on ogt.Id=og.Ogretmen_Id and ogt.Statu=1
where ood.Statu=1
and og.Donem_Id = 1
and o.Id = 6
and do.Id = 1
group by o.Id,og.Ogretmen_Id,o.Adi,o.SoyAdi,do.Adi
)B
group by b.Ogrenci_Id,b.adisoyadi,b.dönemadi