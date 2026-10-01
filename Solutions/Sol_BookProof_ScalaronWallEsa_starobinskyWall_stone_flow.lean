-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.starobinskyWall_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_symmetricOn
import Theorems.Thm_BookProof_ScalaronWallEsa_starobinskyWall_esa
import Theorems.Thm_BookProof_ScalaronEsa_ccDomain_dense
import Theorems.Thm_BookProof_ScalaronEsa_contDiff_starobinskyV
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.ScalaronWallEsa




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
obinskyV M alpha phi) (contDiff_starobinskyV M alpha)) :=
  wallHam_essentiallySelfAdjoint _ _ (fun phi => starobinskyV_nonneg halpha phi)

theorem solution {M alpha : ℝ} (halpha : 0 < alpha) :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 (volume : Measure ℝ)))
      (U : ℝ → (Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ))),
      IsSelfAdjointExtension :=
           (wallHam (fun phi : ℝ => starobinskyV M alpha phi)
              (contDiff_starobinskyV M al
