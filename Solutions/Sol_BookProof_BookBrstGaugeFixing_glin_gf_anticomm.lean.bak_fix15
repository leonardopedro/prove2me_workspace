-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.glin_gf_anticomm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hCAR : GhostCAR χ β)
    (hGβ : ∀ a b, Gc a * β b = β b * Gc a)
    (hBχ : ∀ a b, B a * χ b = χ b * B a) (hBβ : ∀ a b, B a * β b = β b * B a) :
    glin Gc χ * gfFermion β B + gfFermion β B * glin Gc χ
      = (∑ c, Gc c * B c) - ∑ c, ∑ d, (Gc c * B d - B d * Gc c) * (β d * χ c) := by

  classical
  have hL : glin Gc χ * gfFermion β B = ∑ c, ∑ d, (Gc c * B d) * (χ c * β d) := by
    unfold glin gfFermion
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun d _ => ?_
    have h1 : χ c * (β d * B d) = B d * (χ c * β d) := by
      rw [← hBβ d d, ← mul_assoc, ← hBχ d c, mul_assoc]
    calc (Gc c * χ c) * (β d * B d) = Gc c * (χ c * (β d * B d)) := by rw [mul_assoc]
      _ = Gc c * (B d * (χ c * β d)) := by rw [h1]
      _ = (Gc c * B d) * (χ c * β d) := by rw [mul_assoc]
  have hR : gfFermion β B * glin Gc χ = ∑ c, ∑ d, (B d * Gc c) * (β d * χ c) := by
    unfold glin gfFermion
    rw [Finset.sum_mul]
    have hterm2 : ∀ c d : Fin n, (β d * B d) * (Gc c * χ c) = (B d * Gc c) * (β d * χ c) := by
      intro c d
      have h2 : β d * (B d * Gc c) = (B d * Gc c) * β d := by
        rw [← mul_assoc, ← hBβ d d, mul_assoc, ← hGβ c d, ← mul_assoc]
      calc (β d * B d) * (Gc c * χ c) = (β d * (B d * Gc c)) * χ c := by noncomm_ring
        _ = ((B d * Gc c) * β d) * χ c := by rw [h2]
        _ = (B d * Gc c) * (β d * χ c) := by noncomm_ring
    have hstep : ∀ d : Fin n, (β d * B d) * (∑ c, Gc c * χ c)
        = ∑ c, (B d * Gc c) * (β d * χ c) := by
      intro d
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun c _ => hterm2 c d
    rw [Finset.sum_congr rfl fun d _ => hstep d,
      Finset.sum_comm (f := fun d c => (B d * Gc c) * (β d * χ c))]
  have hterm : ∀ c d : Fin n,
      (Gc c * B d) * (χ c * β d) + (B d * Gc c) * (β d * χ c)
        = (if d = c then Gc c * B c else 0)
          - (Gc c * B d - B d * Gc c) * (β d * χ c) := by
    intro c d
    have hcar : β d * χ c + χ c * β d = if d = c then 1 else 0 := hCAR.betachi d c
    have hexp : (Gc c * B d) * (χ c * β d) + (B d * Gc c) * (β d * χ c)
        = (Gc c * B d) * (χ c * β d + β d * χ c)
          - (Gc c * B d - B d * Gc c) * (β d * χ c) := by noncomm_ring
    rw [hexp, add_comm (χ c * β d) (β d * χ c), hcar]
    by_cases h : d = c
    · subst h
      simp
    · simp [h]
  rw [hL, hR, ← Finset.sum_add_distrib]
  have hstep : ∀ c : Fin n,
      (∑ d, (Gc c * B d) * (χ c * β d)) + (∑ d, (B d * Gc c) * (β d * χ c))
        = (Gc c * B c) - ∑ d, (Gc c * B d - B d * Gc c) * (β d * χ c) := by
    intro c
    rw [← Finset.sum_add_distrib, Finset.sum_congr rfl fun d _ => hterm c d,
      Finset.sum_sub_distrib]
    simp
  rw [Finset.sum_congr rfl fun c _ => hstep c, Finset.sum_sub_distrib]
