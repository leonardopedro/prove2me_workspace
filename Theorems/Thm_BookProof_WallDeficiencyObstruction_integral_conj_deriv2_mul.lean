-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.integral_conj_deriv2_mul
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterA4



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.integral_conj_deriv2_mul {P P' P'' : ℝ → ℂ} {W W' G : ℝ → ℂ}
    (hP : ∀ x, HasDerivAt P (P' x) x) (hP' : ∀ x, HasDerivAt P' (P'' x) x)
    (hP''c : Continuous P'') (hPsupp : HasCompactSupport P)
    (hW : ∀ x, HasDerivAt W (W' x) x) (hW' : ∀ x, HasDerivAt W' (G x) x)
    (hGc : Continuous G) :
    ∫ x, (starRingEnd ℂ) (P'' x) * W x = ∫ x, (starRingEnd ℂ) (P x) * G x := by sorry
