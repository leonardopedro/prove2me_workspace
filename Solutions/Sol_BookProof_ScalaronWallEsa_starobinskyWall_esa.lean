-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.starobinskyWall_esa
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_essentiallySelfAdjoint
import Theorems.Thm_BookProof_ScalaronEsa_contDiff_starobinskyV
import Theorems.Thm_BookProof_Starobinsky_starobinskyV_nonneg
open BookProof.ScalaronWallEsa




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
⟨wallHam_deficiencyTrivialAt V hV hVnn (by simp),
    wallHam_deficiencyTrivialAt V hV hVnn (by simp)⟩

theorem solution {M alpha : ℝ} (halpha : 0 < alpha :=
  ) :
      EssentiallySelfAdjointOn (ccDomain ℝ)
        (wallHam (fun phi : ℝ => st
