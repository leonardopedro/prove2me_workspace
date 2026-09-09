import Mathlib
import BookProof.ChapterReconstruct

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system"
— the density-matrix / trace form of the main result
*"Time translation is a stochastic process if and only if it is deterministic"*

This file formalizes the **literal density-matrix statement** of the section
*"Time translation is a stochastic process if and only if it is deterministic"*
(`book.tex` line ~2613), one of the book's stated *"main results"*.

The book reduces the existence of a group action of a Wigner symmetry group on the
probability distribution to the equality, for every pure state `ρ_g = |Ψ⟩⟨Ψ|`,
every outcome `A = a` (rank-one projection `P_a = |e_a⟩⟨e_a|`) and every unitary
`U`, of the two Born probabilities

* `tr(diag(ρ_g) · U P_a U†)` — the probability obtained if the state first
  *collapses* to its diagonal (classical) part and then the transformation acts, and
* `tr(ρ_g · U P_a U†)` — the probability obtained if the transformation acts on the
  full quantum state.

The book then observes this equality is equivalent to the vanishing of the
off-diagonal Born sum `∑_{k≠b} conj(U k a)·Ψ k·conj(Ψ b)·U b a`, which is in turn
equivalent to `U` being *deterministic* (each column has at most one nonzero
entry). The off-diagonal core `↔` determinism is already established in
`BookProof.ChapterReconstruct` (`offDiag_eq_zero_iff_isDeterministic`,
`offDiag_unit_iff`). This file supplies the missing **density-matrix layer**: it
identifies the two matrix traces with the full/collapsed Born sums, shows their
difference is exactly the off-diagonal sum, and packages the headline equivalence

    (∀ a Ψ, tr(diag(ρ Ψ) · U P_a U†) = tr(ρ Ψ · U P_a U†)) ↔ IsDeterministic U

both over all states and over pure states (`∑ ‖Ψ k‖² = 1`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct

namespace BookProof.ChapterTimeTranslation

variable {n : ℕ}

/-- The pure-state density matrix `ρ = |Ψ⟩⟨Ψ|`, with entries `ρ i j = Ψ i · conj(Ψ j)`. -/
def rho (Ψ : Fin n → ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  Matrix.of fun i j => Ψ i * (starRingEnd ℂ) (Ψ j)

/-- The diagonal (collapsed) part of a matrix: keep the diagonal, zero the rest.
This is the wave-function collapse in the measurement basis. -/
def diagPart (M : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  Matrix.of fun i j => if i = j then M i j else 0

/-- The rank-one projection `P_a = |e_a⟩⟨e_a|` onto the basis outcome `a`. -/
def proj (a : Fin n) : Matrix (Fin n) (Fin n) ℂ :=
  Matrix.of fun i j => if i = a ∧ j = a then 1 else 0

/-- The transformed measurement operator `M_a = U P_a U†`. -/
noncomputable def measOp (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) : Matrix (Fin n) (Fin n) ℂ :=
  U * proj a * Uᴴ

/-
Entries of the measurement operator: `(U P_a U†) k l = U k a · conj(U l a)`.
-/
theorem measOp_apply (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (k l : Fin n) :
    measOp U a k l = U k a * (starRingEnd ℂ) (U l a) := by
  unfold measOp;
  simp only [proj, mul_apply, of_apply, mul_ite, mul_one, mul_zero, conjTranspose_apply,
      RCLike.star_def];
  rw [ Finset.sum_eq_single a ] <;> aesop

/-
The "full" Born probability is the trace of `ρ · M_a`; expanded it is the
double sum `∑_{i,k} conj(U i a)·Ψ i · conj(Ψ k)·U k a`.
-/
theorem trace_rho_measOp (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    (rho Ψ * measOp U a).trace =
      (∑ k : Fin n, (starRingEnd ℂ) (U k a) * Ψ k) *
        (∑ b : Fin n, (starRingEnd ℂ) (Ψ b) * U b a) := by
  -- Expand the trace of the product.
  simp [Matrix.trace, Matrix.mul_apply, rho, measOp_apply];
  simp only [mul_comm, mul_left_comm, Finset.mul_sum _ _ _]

/-
The "collapsed" Born probability is the trace of `diag(ρ) · M_a`; expanded it
is the diagonal sum `∑_i |Ψ i|²·|U i a|²`.
-/
theorem trace_diagPart_measOp (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    (diagPart (rho Ψ) * measOp U a).trace =
      ∑ k : Fin n,
        (starRingEnd ℂ) (U k a) * Ψ k * (starRingEnd ℂ) (Ψ k) * U k a := by
  unfold diagPart; simp only [trace, rho, of_apply, diag_apply, mul_apply, measOp_apply, ite_mul,
      zero_mul, sum_ite_eq, mem_univ, ↓reduceIte] ;
  exact Finset.sum_congr rfl fun _ _ => by ring;

/-- **Key identity.** The difference between the full and the collapsed Born
probability is exactly the off-diagonal Born sum of `ChapterReconstruct`. -/
theorem trace_diff (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    (rho Ψ * measOp U a).trace - (diagPart (rho Ψ) * measOp U a).trace
      = offDiag U a Ψ := by
  rw [trace_rho_measOp, trace_diagPart_measOp, offDiag_eq]

/-- **Headline (density-matrix form).** The collapsed and full Born probabilities
agree for every outcome `a` and every state `Ψ` — i.e. the symmetry `U` induces a
well-defined group action on probability distributions — **iff** `U` is
deterministic (each column has at most one nonzero entry). This is the literal
density-matrix statement of the book's *"time translation is a stochastic process
if and only if it is deterministic"*. -/
theorem trace_eq_iff_isDeterministic (U : Matrix (Fin n) (Fin n) ℂ) :
    (∀ (a : Fin n) (Ψ : Fin n → ℂ),
        (diagPart (rho Ψ) * measOp U a).trace = (rho Ψ * measOp U a).trace)
      ↔ IsDeterministic U := by
  rw [← offDiag_eq_zero_iff_isDeterministic]
  constructor
  · intro h a Ψ
    have hd := trace_diff U a Ψ
    rw [h a Ψ, sub_self] at hd
    exact hd.symm
  · intro h a Ψ
    have hd := trace_diff U a Ψ
    rw [h a Ψ, sub_eq_zero] at hd
    exact hd.symm

/-- **Headline (pure-state form).** Restricting to pure states (`∑ ‖Ψ k‖² = 1`,
i.e. genuine density matrices `|Ψ⟩⟨Ψ|`) does not change the equivalence: the
collapsed and full Born probabilities agree on all pure states and outcomes iff
`U` is deterministic. This is exactly the book's quantifier "for any pure density
matrix `ρ_g`". -/
theorem trace_eq_iff_isDeterministic_pure (U : Matrix (Fin n) (Fin n) ℂ) :
    (∀ (a : Fin n) (Ψ : Fin n → ℂ), (∑ k : Fin n, ‖Ψ k‖ ^ 2) = 1 →
        (diagPart (rho Ψ) * measOp U a).trace = (rho Ψ * measOp U a).trace)
      ↔ IsDeterministic U := by
  rw [← offDiag_unit_iff]
  constructor
  · intro h a Ψ hΨ
    have hd := trace_diff U a Ψ
    rw [h a Ψ hΨ, sub_self] at hd
    exact hd.symm
  · intro h a Ψ hΨ
    have hd := trace_diff U a Ψ
    rw [h a Ψ hΨ, sub_eq_zero] at hd
    exact hd.symm

end BookProof.ChapterTimeTranslation
