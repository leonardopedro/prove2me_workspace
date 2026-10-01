-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.qgSymbol_homogeneous
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.qgSymbol_homogeneous {n : ℕ} (c : ℝ) (xi : Fin n → ℝ) (xiY : ℝ) :
    qgSymbol (fun a => c * xi a) (c * xiY) = c ^ 2 * qgSymbol xi xiY := by sorry
