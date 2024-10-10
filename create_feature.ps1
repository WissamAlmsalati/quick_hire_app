# Check if feature name is provided
if (-not $args[0]) {
    Write-Host "Usage: .\create_feature.ps1 <feature_name>"
    exit 1
}

$FEATURE_NAME = $args[0]

# Define the base directory
$BASE_DIR = "lib/features/$FEATURE_NAME"

# Create the directory structure
New-Item -ItemType Directory -Force -Path "$BASE_DIR/data/datasources"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/data/models"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/data/repositories"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/domain/entities"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/domain/repositories"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/domain/usecases"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/presentation/bloc"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/presentation/pages"
New-Item -ItemType Directory -Force -Path "$BASE_DIR/presentation/widgets"

# Create placeholder files
New-Item -ItemType File -Force -Path "$BASE_DIR/data/datasources/${FEATURE_NAME}_remote_data_source.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/data/models/${FEATURE_NAME}_model.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/data/repositories/${FEATURE_NAME}_repository_impl.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/domain/entities/${FEATURE_NAME}.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/domain/repositories/${FEATURE_NAME}_repository.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/domain/usecases/get_${FEATURE_NAME}s.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/presentation/bloc/${FEATURE_NAME}_bloc.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/presentation/pages/${FEATURE_NAME}_page.dart"
New-Item -ItemType File -Force -Path "$BASE_DIR/presentation/widgets/${FEATURE_NAME}_widget.dart"

Write-Host "Feature '$FEATURE_NAME' structure created successfully."