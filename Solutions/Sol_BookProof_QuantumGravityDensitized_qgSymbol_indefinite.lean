-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgSymbol_indefinite
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_qgSymbol_pos
import Theorems.Thm_BookProof_QuantumGravityDensitized_qgSymbol_neg
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution :
    (∃ (xi : Fin 1 → ℝ) (xiY : ℝ), 0 < qgSymbol xi xiY) ∧
      (∃ (xi : Fin 1 → ℝ) (xiY : ℝ), qgSymbol xi xiY < 0) := ⟨⟨fun _ => 1, 0, qgSymbol_pos⟩, ⟨fun _ => 0, 1, qgSymbol_neg⟩⟩
