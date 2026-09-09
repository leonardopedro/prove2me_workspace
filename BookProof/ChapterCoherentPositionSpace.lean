import Mathlib
import BookProof.ChapterCoherentOverlap
import BookProof.ChapterSoftmaxSharpness

/-!
# Chapter "The Coherent State of Attention" — the position-space realization of the
overlap

`ChapterCoherentOverlap` takes the Bargmann–Fock reproducing kernel
`⟨q|k⟩ = exp (-‖q‖²/2 - ‖k‖²/2 + ⟪q,k⟫)` as the *definition* of the coherent-state
overlap.  This module derives the same kernel from the concrete **position-space
wave functions** of the corresponding minimum-uncertainty wave packets, so that
the kernel is no longer a definition but the value of an honest `L²(ℝ)` inner
product.

With `ℏ = m = ω = 1`, the coherent state displaced to the position `a` has the
normalized wave function

  `ψ_a(x) = π^{-1/4} exp (-(x - a)²/2)`,

and the module proves:

* `gaussianPacket_sq_integral` — `∫ ψ_a(x)² dx = 1`: the packet is normalized;
* `gaussianPacket_inner` — **the headline**: `∫ ψ_a(x) ψ_b(x) dx = exp (-(a-b)²/4)`,
  a pure function of the distance between the two packet centres;
* `gaussianPacket_inner_sq_eq_coherentOverlap` — squaring gives the Born
  probability `|⟨ψ_a|ψ_b⟩|² = exp (-(a-b)²/2)`, which is exactly the real
  coherent-overlap kernel of `ChapterCoherentOverlap` at the parameters `a, b`;
* `packetBorn_eq_scoreSoftmax` — consequently the position-space Born weights of a
  query packet against a family of key packets are the Softmax of minus the squared
  distances at inverse temperature `1/2`.

Conventions: the physics parameter of a coherent state is `α = (a + i p)/√2`, so
the fidelity `|⟨α|β⟩|² = exp (-|α - β|²)` becomes `exp (-(a-b)²/2)` in terms of the
positions `a, b` of two zero-momentum packets; this is the convention under which
the real kernel of `ChapterCoherentOverlap` is recovered on the nose.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators
open MeasureTheory

noncomputable section

namespace BookProof.ChapterCoherentPositionSpace

open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

/-! ## The normalized Gaussian wave packet -/

/-- The normalization constant `π^{-1/4}` of the ground-state wave packet, written
as `1 / √(√π)`. -/
def packetNorm : ℝ := (Real.sqrt (Real.sqrt Real.pi))⁻¹

theorem sqrt_pi_pos : 0 < Real.sqrt Real.pi := Real.sqrt_pos.2 Real.pi_pos

theorem packetNorm_pos : 0 < packetNorm :=
  inv_pos.2 (Real.sqrt_pos.2 sqrt_pi_pos)

/-- `π^{-1/4}` squared is `π^{-1/2}`. -/
theorem packetNorm_sq : packetNorm ^ 2 = (Real.sqrt Real.pi)⁻¹ := by
  rw [packetNorm, inv_pow, Real.sq_sqrt sqrt_pi_pos.le]

/-- The **position-space wave function of the coherent state centred at `a`**
(zero momentum), `ψ_a(x) = π^{-1/4} exp (-(x - a)²/2)`. -/
def gaussianPacket (a x : ℝ) : ℝ := packetNorm * Real.exp (-(x - a) ^ 2 / 2)

theorem gaussianPacket_pos (a x : ℝ) : 0 < gaussianPacket a x :=
  mul_pos packetNorm_pos (Real.exp_pos _)

/-! ## The Gaussian integral -/

/-- The translated Gaussian integral `∫ exp (-(x - c)²) dx = √π`. -/
theorem integral_exp_neg_sq_sub (c : ℝ) :
    (∫ x : ℝ, Real.exp (-(x - c) ^ 2)) = Real.sqrt Real.pi := by
  have h := MeasureTheory.integral_sub_right_eq_self (μ := (volume : Measure ℝ))
      (fun x : ℝ => Real.exp (-x ^ 2)) c
  simp only at h
  rw [h]
  simpa using integral_gaussian 1

/-- The **product of two displaced Gaussians integrates to a Gaussian in the
displacement**: `∫ exp (-(x-a)²/2) exp (-(x-b)²/2) dx = exp (-(a-b)²/4) √π`. -/
theorem integral_exp_mul_exp (a b : ℝ) :
    (∫ x : ℝ, Real.exp (-(x - a) ^ 2 / 2) * Real.exp (-(x - b) ^ 2 / 2))
      = Real.exp (-(a - b) ^ 2 / 4) * Real.sqrt Real.pi := by
  have hpt : ∀ x : ℝ, Real.exp (-(x - a) ^ 2 / 2) * Real.exp (-(x - b) ^ 2 / 2)
      = Real.exp (-(a - b) ^ 2 / 4) * Real.exp (-(x - (a + b) / 2) ^ 2) := by
    intro x
    rw [← Real.exp_add, ← Real.exp_add]
    ring_nf
  calc (∫ x : ℝ, Real.exp (-(x - a) ^ 2 / 2) * Real.exp (-(x - b) ^ 2 / 2))
      = ∫ x : ℝ, Real.exp (-(a - b) ^ 2 / 4) * Real.exp (-(x - (a + b) / 2) ^ 2) :=
        integral_congr_ae (Filter.Eventually.of_forall hpt)
    _ = Real.exp (-(a - b) ^ 2 / 4) * Real.sqrt Real.pi := by
        rw [MeasureTheory.integral_const_mul, integral_exp_neg_sq_sub]

/-! ## The overlap of two packets -/

/-- **The `L²(ℝ)` inner product of two coherent wave packets is a Gaussian in the
distance between their centres:** `⟨ψ_a, ψ_b⟩ = exp (-(a-b)²/4)`. -/
theorem gaussianPacket_inner (a b : ℝ) :
    (∫ x : ℝ, gaussianPacket a x * gaussianPacket b x) = Real.exp (-(a - b) ^ 2 / 4) := by
  have hpt : ∀ x : ℝ, gaussianPacket a x * gaussianPacket b x
      = packetNorm ^ 2 * (Real.exp (-(x - a) ^ 2 / 2) * Real.exp (-(x - b) ^ 2 / 2)) := by
    intro x; simp only [gaussianPacket]; ring
  rw [integral_congr_ae (Filter.Eventually.of_forall hpt),
    MeasureTheory.integral_const_mul, integral_exp_mul_exp, packetNorm_sq]
  field_simp

/-- **The packet is normalized**: `∫ ψ_a(x)² dx = 1`. -/
theorem gaussianPacket_sq_integral (a : ℝ) :
    (∫ x : ℝ, gaussianPacket a x * gaussianPacket a x) = 1 := by
  rw [gaussianPacket_inner]; simp

/-- The overlap of two packets is strictly positive. -/
theorem gaussianPacket_inner_pos (a b : ℝ) :
    0 < ∫ x : ℝ, gaussianPacket a x * gaussianPacket b x := by
  rw [gaussianPacket_inner]; exact Real.exp_pos _

/-- The overlap never exceeds `1`, with equality exactly on the diagonal. -/
theorem gaussianPacket_inner_le_one (a b : ℝ) :
    (∫ x : ℝ, gaussianPacket a x * gaussianPacket b x) ≤ 1 := by
  rw [gaussianPacket_inner, Real.exp_le_one_iff]
  nlinarith [sq_nonneg (a - b)]

theorem gaussianPacket_inner_eq_one_iff (a b : ℝ) :
    (∫ x : ℝ, gaussianPacket a x * gaussianPacket b x) = 1 ↔ a = b := by
  rw [gaussianPacket_inner, Real.exp_eq_one_iff]
  constructor
  · intro h
    have : (a - b) ^ 2 = 0 := by linarith
    have := pow_eq_zero_iff (n := 2) two_ne_zero |>.1 this
    linarith
  · rintro rfl; ring

/-! ## Recovering the Bargmann kernel and the Softmax weights -/

/-- **The Born probability of the packet overlap is the real coherent-overlap
kernel.**  Squaring the position-space inner product recovers exactly the
Bargmann–Fock kernel of `ChapterCoherentOverlap` evaluated at the one-dimensional
parameters `a` and `b`. -/
theorem gaussianPacket_inner_sq_eq_coherentOverlap (a b : ℝ) :
    (∫ x : ℝ, gaussianPacket a x * gaussianPacket b x) ^ 2
      = coherentOverlap (WithLp.toLp 2 (fun _ => a) : EuclideanSpace ℝ (Fin 1))
          (WithLp.toLp 2 (fun _ => b)) := by
  have hq : ‖(WithLp.toLp 2 (fun _ => a) : EuclideanSpace ℝ (Fin 1))‖ ^ 2 = a * a := by
    rw [norm_sq_eq_sum]; simp
  have hk : ‖(WithLp.toLp 2 (fun _ => b) : EuclideanSpace ℝ (Fin 1))‖ ^ 2 = b * b := by
    rw [norm_sq_eq_sum]; simp
  have hin : (inner ℝ (WithLp.toLp 2 (fun _ => a) : EuclideanSpace ℝ (Fin 1))
      (WithLp.toLp 2 (fun _ => b) : EuclideanSpace ℝ (Fin 1)) : ℝ) = a * b := by
    rw [inner_eq_sum]; simp
  rw [gaussianPacket_inner, ← Real.exp_nat_mul, coherentOverlap, hq, hk, hin]
  ring_nf

/-- The **position-space attention weights**: the Born weight of the key packet
centred at `k j` against the query packet centred at `q`. -/
def packetBorn {m : ℕ} (q : ℝ) (k : Fin m → ℝ) (j : Fin m) : ℝ :=
  (∫ x : ℝ, gaussianPacket q x * gaussianPacket (k j) x) ^ 2 /
    ∑ l, (∫ x : ℝ, gaussianPacket q x * gaussianPacket (k l) x) ^ 2

/-- **The position-space Born weights are Softmax attention** over minus the
squared distances, at inverse temperature `1/2`. -/
theorem packetBorn_eq_scoreSoftmax {m : ℕ} (q : ℝ) (k : Fin m → ℝ) (j : Fin m) :
    packetBorn q k j = scoreSoftmax (1 / 2) (fun l => -(q - k l) ^ 2) j := by
  have hpt : ∀ l : Fin m,
      (∫ x : ℝ, gaussianPacket q x * gaussianPacket (k l) x) ^ 2
        = Real.exp (1 / 2 * -(q - k l) ^ 2) := by
    intro l
    rw [gaussianPacket_inner, ← Real.exp_nat_mul]
    ring_nf
  rw [packetBorn, scoreSoftmax, hpt j, Finset.sum_congr rfl fun l _ => hpt l]

end BookProof.ChapterCoherentPositionSpace

end
