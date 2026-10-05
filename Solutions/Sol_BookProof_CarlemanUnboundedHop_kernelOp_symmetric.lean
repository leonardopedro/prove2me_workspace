-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.kernelOp_symmetric
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) :
    SymmetricOn (lpFiniteModes ℕ) (kernelOp hk) := by

  intro x y
  obtain ⟨Mx, hMx⟩ := exists_tail_zero x.2
  obtain ⟨My, hMy⟩ := exists_tail_zero y.2
  have hL : (inner ℂ (kernelOp hk x : L2N) (y : L2N) : ℂ)
      = ∑ n ∈ range My, ∑ k ∈ range Mx,
          ((y : L2N) : ℕ → ℂ) n * ((starRingEnd ℂ) (a n k)
            * (starRingEnd ℂ) (((x : L2N) : ℕ → ℂ) k)) := by
    rw [← inner_conj_symm, inner_eq_sum_range (f := (y : L2N)) hMy, map_sum]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [map_mul, Complex.conj_conj]
    change ((y : L2N) : ℕ → ℂ) n * (starRingEnd ℂ) (kernelFun a ((x : L2N) : ℕ → ℂ) n) = _
    rw [kernelFun_eq_sum a hMx n, map_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [map_mul]
  have hR : (inner ℂ (x : L2N) (kernelOp hk y : L2N) : ℂ)
      = ∑ k ∈ range Mx, ∑ n ∈ range My,
          (starRingEnd ℂ) (((x : L2N) : ℕ → ℂ) k) * (a k n * ((y : L2N) : ℕ → ℂ) n) := by
    rw [inner_eq_sum_range (f := (x : L2N)) hMx]
    refine Finset.sum_congr rfl fun k _ => ?_
    change (starRingEnd ℂ) (((x : L2N) : ℕ → ℂ) k) * kernelFun a ((y : L2N) : ℕ → ℂ) k = _
    rw [kernelFun_eq_sum a hMy k, Finset.mul_sum]
  rw [hL, hR, Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun n _ => ?_
  rw [hk.herm n k]
  ring
