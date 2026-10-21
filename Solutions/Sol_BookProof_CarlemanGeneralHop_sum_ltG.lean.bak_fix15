-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.sum_ltG
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_hshift_hshift
import Theorems.Thm_BookProof_CarlemanGeneralHop_ltG_eq_conj_rtG
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
    ∑ a ∈ A, ltG u w c' p m a
      = (starRingEnd ℂ) (∑ b ∈ hopB A p m, rtG u w c p m b) := by

  classical
  have hfil : ∑ a ∈ A, ltG u w c' p m a
      = ∑ a ∈ A.filter (fun a => ∀ k, p k ≤ a k), ltG u w c' p m a := by
    refine (Finset.sum_filter_of_ne ?_).symm
    intro a _ hne
    by_contra hlt
    exact hne (by rw [ltG, hvanL a hlt]; simp)
  rw [hfil, hopB, Finset.sum_image, map_sum]
  · refine Finset.sum_congr rfl fun a ha => ?_
    rw [Finset.mem_filter] at ha
    exact ltG_eq_conj_rtG hcomp ha.2
  · intro x hx y hy hxy
    simp only [Finset.mem_coe, Finset.mem_filter] at hx hy
    have := congrArg (hshift p m) hxy
    rwa [hshift_hshift hx.2, hshift_hshift hy.2] at this
