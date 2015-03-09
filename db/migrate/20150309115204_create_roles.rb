class CreateRoles < ActiveRecord::Migration
  def up
    execute 'CREATE ROLE forestapp_admin;'
    execute 'GRANT ALL ON ALL TABLES IN SCHEMA public TO forestapp_admin;'
    execute 'GRANT ALL ON public.plantaciones_id_seq TO forestapp_admin;'

    execute 'CREATE ROLE rbenit IN ROLE forestapp_admin LOGIN;'
    execute 'CREATE ROLE myorio IN ROLE forestapp_admin LOGIN;'
    execute 'CREATE ROLE mgaute IN ROLE forestapp_admin LOGIN;'
    execute 'CREATE ROLE maumiranda IN ROLE forestapp_admin LOGIN;'

    execute 'CREATE ROLE forestapp_editor;'
    execute 'GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO forestapp_editor;'
    execute 'GRANT ALL ON public.plantaciones_id_seq TO forestapp_editor;'

    execute 'CREATE ROLE anapla IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE flaxag IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE prighe IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE fpietra IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE ncleme IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE gscior IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE espinetto IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE fhorn IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE ipoch IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE ademarc IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE ntripo IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE mcsmit IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE lbalfonzo IN ROLE forestapp_editor LOGIN;'
    execute 'CREATE ROLE privolta IN ROLE forestapp_editor LOGIN;'
  end

  def down
    execute 'DROP ROLE rbenit;'
    execute 'DROP ROLE myorio;'
    execute 'DROP ROLE mgaute;'
    execute 'DROP ROLE maumiranda;'
    execute 'DROP ROLE forestapp_admin;'

    execute 'DROP ROLE anapla;'
    execute 'DROP ROLE flaxag;'
    execute 'DROP ROLE prighe;'
    execute 'DROP ROLE fpietra;'
    execute 'DROP ROLE ncleme;'
    execute 'DROP ROLE gscior;'
    execute 'DROP ROLE espinetto;'
    execute 'DROP ROLE fhorn;'
    execute 'DROP ROLE ipoch;'
    execute 'DROP ROLE ademarc;'
    execute 'DROP ROLE ntripo;'
    execute 'DROP ROLE mcsmit;'
    execute 'DROP ROLE lbalfonzo;'
    execute 'DROP ROLE privolta;'
    execute 'DROP ROLE forestapp_editor;'
  end
end
