-- Generated from ChapterWallEsaBddBelow.lean — solution of BookProof.WallEsaBddBelow.oscillatorPlus_esa
import Mathlib
import Definitions.Def_ChapterWallEsaBddBelow
import Theorems.Thm_BookProof_WallEsaBddBelow_wallHam_essentiallySelfAdjoint_of_bddBelow
open BookProof.WallEsaBddBelow




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
    EssentiallySelfAdjointOn (ccDomain ℝ)
      (wallHam (fun x => x ^ 2 / 4 + V x)
        (((contDiff_id.pow 2).div_const 4).add hV)) :=
   V x)
          (((contDiff_id.pow 2).div_const 4).add hV)) :=
    wallHam_essentiallySelfAdjoint_of_bddBelow _ _ (c := c) fun x => by
      have h1 : (0 : ℝ) ≤ x
