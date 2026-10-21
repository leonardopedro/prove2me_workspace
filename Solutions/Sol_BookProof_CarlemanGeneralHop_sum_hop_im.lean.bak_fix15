-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.sum_hop_im
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_sum_ltG
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {w : ℂ} {c c' : (Fin d →₀ ℕ) → ℝ} {p m : Fin d →₀ ℕ}
    (hcomp : ∀ b : Fin d →₀ ℕ, (∀ k, m k ≤ b k) → c' (hshift p m b) = c b)
    (hvanL : ∀ a : Fin d →₀ ℕ, ¬ (∀ k, p k ≤ a k) → c' a = 0) (A : Finset (Fin d →₀ ℕ)) :
    (∑ a ∈ A, (rtG u w c p m a + ltG u w c' p m a)).im
      = (∑ a ∈ A \ hopB A p m, rtG u w c p m a).im
        - (∑ b ∈ hopB A p m \ A, rtG u w c p m b).im := by

  classical
  set B := hopB A p m with hB
  have hsplitA : ∑ a ∈ A, rtG u w c p m a
      = ∑ a ∈ A ∩ B, rtG u w c p m a + ∑ a ∈ A \ B, rtG u w c p m a :=
    (Finset.sum_inter_add_sum_sdiff A B _).symm
  have hsplitB : ∑ a ∈ B, rtG u w c p m a
      = ∑ a ∈ A ∩ B, rtG u w c p m a + ∑ a ∈ B \ A, rtG u w c p m a := by
    rw [Finset.inter_comm]
    exact (Finset.sum_inter_add_sum_sdiff B A _).symm
  rw [Finset.sum_add_distrib, sum_ltG hcomp hvanL A, ← hB, Complex.add_im,
    Complex.conj_im, hsplitA, hsplitB]
  simp only [Complex.add_im]
  ring
