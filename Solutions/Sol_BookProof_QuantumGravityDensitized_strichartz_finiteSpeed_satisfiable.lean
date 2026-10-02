-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.strichartz_finiteSpeed_satisfiable
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_qgModeHamiltonian_deficiencyTrivialAt
import Theorems.Thm_BookProof_QuantumGravityDensitized_strichartz_esa_of_finiteSpeed
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (a b V : ℕ → ℝ) :
    EssentiallySelfAdjointOn (mulSymbolDomain (qgModeSymbol a b V)) (qgModeHamiltonian a b V) := strichartz_esa_of_finiteSpeed _ fun _ hz => qgModeHamiltonian_deficiencyTrivialAt a b V hz
