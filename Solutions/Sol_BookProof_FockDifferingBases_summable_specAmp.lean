-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.summable_specAmp
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_norm_specEntry
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {lam : κ → ℝ} {v : κ → ι → ℂ}
    (hv : ∀ k, Summable fun p => ‖v k p‖)
    (hlam : Summable fun k => |lam k| * (∑' p, ‖v k p‖) ^ 2) :
    Summable fun z : κ × ι × ι => ‖specAmp lam v z‖ := by

  have hpt : ∀ z : κ × ι × ι, ‖specAmp lam v z‖
      = (|lam z.1| / 2) * (‖v z.1 z.2.1‖ * ‖v z.1 z.2.2‖) := by
    intro z
    rw [specAmp, norm_specEntry, abs_div]
    simp
  have hnn : (0 : κ × ι × ι → ℝ) ≤ fun z => ‖specAmp lam v z‖ := fun z => norm_nonneg _
  refine (summable_prod_of_nonneg hnn).mpr ⟨fun k => ?_, ?_⟩
  · have hprod : Summable fun w : ι × ι => ‖v k w.1‖ * ‖v k w.2‖ :=
      (hv k).mul_of_nonneg (hv k) (fun _ => norm_nonneg _) (fun _ => norm_nonneg _)
    refine ((hprod.mul_left (|lam k| / 2)).congr fun w => ?_)
    rw [hpt (k, w)]
  · have heq : ∀ k, (∑' w : ι × ι, ‖specAmp lam v (k, w)‖)
        = (|lam k| / 2) * (∑' p, ‖v k p‖) ^ 2 := by
      intro k
      have hprod : Summable fun w : ι × ι => ‖v k w.1‖ * ‖v k w.2‖ :=
        (hv k).mul_of_nonneg (hv k) (fun _ => norm_nonneg _) (fun _ => norm_nonneg _)
      have hmul : (∑' p, ‖v k p‖) * (∑' p, ‖v k p‖)
          = ∑' w : ι × ι, ‖v k w.1‖ * ‖v k w.2‖ :=
        tsum_mul_tsum_of_summable_norm (f := fun p => ‖v k p‖) (g := fun p => ‖v k p‖)
          (by simpa [Real.norm_eq_abs, abs_of_nonneg (norm_nonneg _)] using hv k)
          (by simpa [Real.norm_eq_abs, abs_of_nonneg (norm_nonneg _)] using hv k)
      calc (∑' w : ι × ι, ‖specAmp lam v (k, w)‖)
          = ∑' w : ι × ι, (|lam k| / 2) * (‖v k w.1‖ * ‖v k w.2‖) := by
            exact tsum_congr fun w => hpt (k, w)
        _ = (|lam k| / 2) * ∑' w : ι × ι, (‖v k w.1‖ * ‖v k w.2‖) := by
            rw [tsum_mul_left]
        _ = (|lam k| / 2) * (∑' p, ‖v k p‖) ^ 2 := by rw [← hmul]; ring
    refine ((hlam.mul_left (1 / 2)).congr fun k => ?_)
    rw [heq k]
    ring
