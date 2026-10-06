-- Generated from ChapterWallEsaBddBelow.lean — solution of BookProof.WallEsaBddBelow.scalaronPlus_esa
import Mathlib
import Definitions.Def_ChapterWallEsaBddBelow
import Theorems.Thm_BookProof_WallEsaBddBelow_wallHam_essentiallySelfAdjoint_of_bddBelow
import Theorems.Thm_BookProof_ScalaronEsa_contDiff_starobinskyV
import Theorems.Thm_BookProof_Starobinsky_starobinskyV_nonneg
open BookProof.WallEsaBddBelow




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (halpha : 0 < alpha) (W : ℝ → ℝ)
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) {c : ℝ} (hWc : ∀ x, -c ≤ W x) :
    EssentiallySelfAdjointOn (ccDomain ℝ)
      (wallHam (fun phi => BookProof.Starobinsky.starobinskyV M alpha phi + W phi)
        ((BookProof.ScalaronEsa.contDiff_starobinskyV M alpha).add hW)) :=
  Proof.ScalaronEsa.contDiff_starobinskyV M alpha).add hW)) :=
    wallHam_essentiallySelfAdjoint_of_bddBelow _ _
      (c := c) fun phi => by
        have h1 := BookProof.Starobinsky.starobinskyV_nonneg (
