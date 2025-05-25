import 'package:flutter/material.dart';
import 'package:coffee_app/models/data_models.dart' show Farm;

class EditFarmDialog extends StatefulWidget {
  final Farm farm;
  final void Function(Farm updatedFarm) onSave;

  const EditFarmDialog({super.key, required this.farm, required this.onSave});

  @override
  State<EditFarmDialog> createState() => _EditFarmDialogState();
}

class _EditFarmDialogState extends State<EditFarmDialog> {
  late TextEditingController plotSizeController;
  late TextEditingController coffeeTypeController;
  late TextEditingController additionalInfoController;
  late TextEditingController enumeratorNameController;
  late TextEditingController kebeleController;
  late TextEditingController woredaController;
  late TextEditingController cooperativeController;
  late TextEditingController farmerNameController;
  late TextEditingController collectingCenterController;
  late TextEditingController disturbanceLevelController;

  @override
  void initState() {
    super.initState();
    final farm = widget.farm;

    plotSizeController = TextEditingController(text: farm.plotSize.toString());
    coffeeTypeController = TextEditingController(text: farm.coffeeType);
    additionalInfoController = TextEditingController(text: farm.additionalInfo ?? '');
    enumeratorNameController = TextEditingController(text: farm.enumeratorName);
    kebeleController = TextEditingController(text: farm.kebeleName);
    woredaController = TextEditingController(text: farm.woredaName);
    cooperativeController = TextEditingController(text: farm.cooperativeName);
    farmerNameController = TextEditingController(text: farm.farmerName);
    collectingCenterController = TextEditingController(text: farm.collectingCenterName);
    disturbanceLevelController = TextEditingController(text: farm.disturbance.toString());;
  }

  @override
  void dispose() {
    plotSizeController.dispose();
    coffeeTypeController.dispose();
    additionalInfoController.dispose();
    enumeratorNameController.dispose();
    kebeleController.dispose();
    woredaController.dispose();
    cooperativeController.dispose();
    farmerNameController.dispose();
    collectingCenterController.dispose();
    disturbanceLevelController.dispose();
    super.dispose();
  }

  void save() {
    final updatedFarm = widget.farm
      ..plotSize = double.tryParse(plotSizeController.text) ?? widget.farm.plotSize
      ..coffeeType = coffeeTypeController.text
      ..additionalInfo = additionalInfoController.text
      ..enumeratorName = enumeratorNameController.text
      ..kebeleName = kebeleController.text
      ..woredaName = woredaController.text
      ..cooperativeName = cooperativeController.text
      ..farmerName = farmerNameController.text
      ..collectingCenterName = collectingCenterController.text
      ..disturbance = disturbanceLevelController.text.isNotEmpty
          ? int.tryParse(disturbanceLevelController.text) ?? widget.farm.disturbance
          : widget.farm.disturbance;

    updatedFarm.save();
    widget.onSave(updatedFarm);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Farm'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: plotSizeController, decoration: const InputDecoration(labelText: 'Plot Size (ha)'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: coffeeTypeController, decoration: const InputDecoration(labelText: 'Coffee Type')),
            TextField(controller: additionalInfoController, decoration: const InputDecoration(labelText: 'Additional Info'), maxLines: 2),
            const Divider(),
            TextField(controller: enumeratorNameController, decoration: const InputDecoration(labelText: 'Enumerator Name')),
            TextField(controller: kebeleController, decoration: const InputDecoration(labelText: 'Kebele')),
            TextField(controller: woredaController, decoration: const InputDecoration(labelText: 'Woreda')),
            TextField(controller: cooperativeController, decoration: const InputDecoration(labelText: 'Cooperative')),
            TextField(controller: farmerNameController, decoration: const InputDecoration(labelText: 'Farmer Name')),
            TextField(controller: collectingCenterController, decoration: const InputDecoration(labelText: 'Collecting Center')),
            TextField(controller: disturbanceLevelController, decoration: const InputDecoration(labelText: 'Disturbance Level')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
