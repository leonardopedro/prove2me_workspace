-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.hermiteCoreOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_deficiencyTrivialAt
import Theorems.Thm_BookProof_QuantumGravityDensitized_strichartz_esa_of_finiteSpeed
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) :
    EssentiallySelfAdjointOn hermiteCore (hermiteCoreOp lam) := strichartz_esa_of_finiteSpeed _ fun _ hz => hermiteCoreOp_deficiencyTrivialAt lam hz
