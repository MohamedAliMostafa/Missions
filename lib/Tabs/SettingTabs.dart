
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';
import '../Components/WidgetStyle/StyleTabSetting/Dropdown.dart';
import '../Components/WidgetStyle/StyleTabSetting/TXTLanguage.dart';

class SettingTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var p=Provider.of<MyPro>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        const SizedBox(height: 20,),
        txtLanguage(txt:AppLocalizations.of(context)!.language),
        DropDowm(item1:AppLocalizations.of(context)!.english,item2:AppLocalizations.of(context)!.arabic,select: p.language=="en"?AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic,onchange: (val)
          {

              if(val==AppLocalizations.of(context)!.english)
              {
                p.changeLang("en");
              }
              else
              {

                p.changeLang("ar");
              }

          },),
        txtLanguage(txt:AppLocalizations.of(context)!.mode),
        DropDowm(item1:AppLocalizations.of(context)!.light,item2:AppLocalizations.of(context)!.dark,select:p.mode==ThemeMode.light?AppLocalizations.of(context)!.light:AppLocalizations.of(context)!.dark ,onchange: (v)
        {

          if(v==AppLocalizations.of(context)!.light)
          {
            p.changeTheme(ThemeMode.light);
          }
          else
          {
            p.changeTheme(ThemeMode.dark);
          }

        } ,),

      ],
    );
  }
}
