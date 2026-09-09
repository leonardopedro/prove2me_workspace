import Mathlib
import BookProof.ChapterCoherentOverlapComplex
import BookProof.ChapterCoherentFidelity

/-!
# Chapter "The Coherent State of Attention" — the symmetry group of attention

The Born weights of the coherent-state head are built from the Bargmann kernel
`⟨q|k⟩`, and the kernel only sees norms and inner products.  Everything that
preserves those leaves attention invariant.  This module identifies three such
symmetries and records what each means physically.

Deliverables (all `sorry`-free, `axiom`-free):

* `coherentOverlapC_isometry`, `bornWeightC_isometry` — **unitary invariance**:
  a common unitary change of frame on the query and all the keys changes no
  attention weight;
* `phaseRotate` — the free harmonic evolution of a coherent state,
  `α ↦ e^{iθ}α` (with `θ = -ωt`), together with `phaseRotate_isometry`
  identifying it as a unitary;
* `coherentOverlapC_phaseRotate`, `bornWeightC_phaseRotate` and
  `bornWeightC_evolution_const` — **attention is a constant of the motion**: the
  weights of a head whose query and keys evolve freely under the same
  Hamiltonian do not depend on the time;
* `fidelityC_phaseRotate` — the same statement for the fidelity readout;
* `bornWeightC_translation_invariant` — **displacement covariance**: displacing
  the query and every key by a common vector (a Weyl/Heisenberg translation of
  phase space) leaves the weights unchanged, so only *relative* positions in
  phase space are physical.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterCoherentDynamics

open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

/-! ## Unitary invariance -/

/-- **The Bargmann kernel is unitarily invariant.**  A common unitary change of
frame preserves both norms and inner products, hence the overlap. -/
theorem coherentOverlapC_isometry
    (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (U q) (U k) = coherentOverlapC q k := by
  rw [coherentOverlapC, coherentOverlapC, U.norm_map, U.norm_map, U.inner_map_map]

theorem bornNumerC_isometry (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q k : EuclideanSpace ℂ (Fin n)) : bornNumerC (U q) (U k) = bornNumerC q k := by
  rw [bornNumerC, bornNumerC, coherentOverlapC_isometry]

/-- **Attention is unitarily invariant.**  Rotating the query and every key by the
same unitary leaves every Born weight unchanged: the head measures only relative
geometry. -/
theorem bornWeightC_isometry (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q : EuclideanSpace ℂ (Fin n)) (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (U q) (fun l => U (k l)) j = bornWeightC q k j := by
  rw [bornWeightC, bornWeightC, bornNumerC_isometry]
  congr 1
  exact Finset.sum_congr rfl fun l _ => bornNumerC_isometry U q (k l)

/-! ## Free evolution: the phase rotation -/

/-- The **free harmonic evolution** of a coherent state on the Bargmann
parameters: `α ↦ e^{iθ}α`, with `θ = -ωt` for a mode of frequency `ω`. -/
def phaseRotate (theta : ℝ) (q : EuclideanSpace ℂ (Fin n)) : EuclideanSpace ℂ (Fin n) :=
  Complex.exp (theta * Complex.I) • q

theorem norm_phaseRotate (theta : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    ‖phaseRotate theta q‖ = ‖q‖ := by
  rw [phaseRotate, norm_smul, Complex.norm_exp_ofReal_mul_I, one_mul]

/-- Free evolution preserves the inner product: it is a unitary. -/
theorem inner_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (phaseRotate theta q) (phaseRotate theta k) : ℂ) = inner ℂ q k := by
  rw [phaseRotate, phaseRotate, inner_smul_left, inner_smul_right, ← mul_assoc]
  have h : (starRingEnd ℂ) (Complex.exp (theta * Complex.I)) * Complex.exp (theta * Complex.I)
      = 1 := by
    rw [← Complex.normSq_eq_conj_mul_self]
    norm_cast
    rw [Complex.normSq_eq_norm_sq, Complex.norm_exp_ofReal_mul_I, one_pow]
  rw [h, one_mul]

/-- **The Bargmann kernel is a constant of the free motion.** -/
theorem coherentOverlapC_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (phaseRotate theta q) (phaseRotate theta k) = coherentOverlapC q k := by
  rw [coherentOverlapC, coherentOverlapC, norm_phaseRotate, norm_phaseRotate,
    inner_phaseRotate]

theorem bornNumerC_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC (phaseRotate theta q) (phaseRotate theta k) = bornNumerC q k := by
  rw [bornNumerC, bornNumerC, coherentOverlapC_phaseRotate]

/-- The fidelity of two freely evolving coherent states is constant in time. -/
theorem fidelityC_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC (phaseRotate theta q) (phaseRotate theta k) = fidelityC q k := by
  rw [fidelityC_eq_bornNumerC, fidelityC_eq_bornNumerC, bornNumerC_phaseRotate]

/-- **Attention is a constant of the motion.**  If the query and every key evolve
freely under the same Hamiltonian, no attention weight changes. -/
theorem bornWeightC_phaseRotate (theta : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (phaseRotate theta q) (fun l => phaseRotate theta (k l)) j
      = bornWeightC q k j := by
  rw [bornWeightC, bornWeightC, bornNumerC_phaseRotate]
  congr 1
  exact Finset.sum_congr rfl fun l _ => bornNumerC_phaseRotate theta q (k l)

/-- The same statement read as a dynamical law: at frequency `omega` the weight of
each key is independent of the time `t`. -/
theorem bornWeightC_evolution_const (omega : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) (t : ℝ) :
    bornWeightC (phaseRotate (-(omega * t)) q)
        (fun l => phaseRotate (-(omega * t)) (k l)) j
      = bornWeightC q k j :=
  bornWeightC_phaseRotate _ q k j

/-! ## Displacement covariance -/

/-- **Only relative phase-space positions are physical.**  Displacing the query and
every key by a common vector — a Weyl (Heisenberg) translation — leaves every Born
weight unchanged. -/
theorem bornWeightC_translation_invariant (v q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (q + v) (fun l => k l + v) j = bornWeightC q k j := by
  have hnum : ∀ l : Fin m, bornNumerC (q + v) (k l + v) = bornNumerC q (k l) := by
    intro l
    rw [← fidelityC_eq_bornNumerC, ← fidelityC_eq_bornNumerC,
      fidelityC_translation_invariant]
  rw [bornWeightC, bornWeightC, hnum j]
  congr 1
  exact Finset.sum_congr rfl fun l _ => hnum l

end BookProof.ChapterCoherentDynamics

end
