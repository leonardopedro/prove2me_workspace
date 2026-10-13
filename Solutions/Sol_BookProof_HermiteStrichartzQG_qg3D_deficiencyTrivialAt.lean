-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.qg3D_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_deficiencyTrivialAt
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) {z : ℂ}
    (hz : z.im ≠ 0) :
    DeficiencyTrivialAt hermiteCore (qg3DHermiteHamiltonian xi xiY V) z := hermiteCoreOp_deficiencyTrivialAt _ hz
