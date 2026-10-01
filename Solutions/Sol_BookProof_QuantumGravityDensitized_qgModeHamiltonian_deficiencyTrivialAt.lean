-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgModeHamiltonian_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_mulHamiltonian_deficiencyTrivialAt
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (a b V : ℕ → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (mulSymbolDomain (qgModeSymbol a b V)) (qgModeHamiltonian a b V) z := mulHamiltonian_deficiencyTrivialAt _ hz
