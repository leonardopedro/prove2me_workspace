-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.inner_eq_of_ode
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterA4
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.StrichartzWave



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.inner_eq_of_ode (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ)
    {W W' : ℝ → ℂ} (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW' : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x)
    (hmem : MemLp W 2 (volume : Measure ℝ)) (v : ccDomain ℝ) :
    (inner ℂ (wallHam V hV v) (hmem.toLp W) : ℂ)
      = z * inner ℂ (v : Lp ℂ 2 (volume : Measure ℝ)) (hmem.toLp W) := by sorry
