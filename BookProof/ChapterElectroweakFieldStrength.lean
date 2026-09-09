import Mathlib
import BookProof.ChapterParity
import BookProof.ChapterParitySU2

/-!
# Chapter "On the physical parity transformation and antiparticles" — the electroweak
`SU(2)_L` field strength via the trace projection

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model").  The chapter records the electroweak field-strength tensors as
*trace projections* of the covariant-derivative commutator onto the Pauli generators:

  `W_{μν}^j = -\frac{i}{g}\,\mathrm{tr}([D_μ, D_ν]\,τ^j)
            = ∂_μ W_ν^j - ∂_ν W_μ^j - g\,ε^{jkl} W_μ^k W_ν^l`,
  `B_{μν}   = -\frac{i}{g'}\,\mathrm{tr}([D_μ, D_ν]\,σ_3) = ∂_μ B_ν - ∂_ν B_μ`,

with `D_μ = ∂_μ + i g W_μ^j τ_j/2 + …`.  The self-contained algebraic content — with the
partial derivatives abstracted as free "curvature" inputs — is a computation with the three
Pauli matrices `σ₁, σ₂, σ₃` (`ChapterParitySU2.pauliV`) and the totally antisymmetric
`ε^{jkl}` (`SU(2) ≅ su(2)` structure constants).  The physical modelling (the actual
space-time derivatives, the gauge fields as operator-valued distributions, the Lagrangian)
is left as prose.

Deliverables:

* `pauli_trace_orthonormal` : `tr(σ_a σ_b) = 2 δ_{ab}` — the generators are trace-orthogonal.
* `pauli_triple_trace` : `tr(σ_a σ_b σ_c) = 2 i ε_{abc}` — the closed form for the trace of
  a triple product (the source of the structure constants).
* `pauli_commutator` : `[σ_k, σ_l] = 2 i ∑_m ε_{klm} σ_m` — the `su(2)` commutation relations.
* `pauli_commutator_trace` : `tr([σ_k, σ_l] σ_j) = 4 i ε_{klj}`.
* `connection_comm_trace` : the trace projection of the quadratic (commutator) part of the
  curvature reproduces `i ∑_{k,l} ε_{klj} W_μ^k W_ν^l`.
* **`electroweak_fieldStrength`** (headline) : the full non-abelian trace-projection formula
  `-\frac{i}{g}\,\mathrm{tr}(F_{μν}\,σ^j) = G_j - g\,ε^{jkl} W_μ^k W_ν^l`, where `G_j` is the
  linear (curl) part `∂_μ W_ν^j - ∂_ν W_μ^j` and
  `F_{μν} = i g\,(∑_j G_j\,σ_j/2) + (i g)²\,[A_μ, A_ν]` is the `su(2)` curvature written
  from the covariant-derivative commutator `[D_μ, D_ν]`.
* **`abelian_fieldStrength`** (companion) : for a single abelian (`U(1)`) field the quadratic
  term drops out and the trace projection returns the pure curl `-\frac{i}{g}\,
  \mathrm{tr}(F_{μν}\,σ_3) = G` (`B_{μν} = ∂_μ B_ν - ∂_ν B_μ`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterElectroweakFieldStrength

open BookProof.ChapterParity BookProof.ChapterParitySU2

/-- The totally antisymmetric Levi-Civita symbol `ε_{ijk}` on `Fin 3` (as a complex number),
the `su(2)` structure constants. -/
def eps (i j k : Fin 3) : ℂ :=
  if i = 0 ∧ j = 1 ∧ k = 2 then 1
  else if i = 1 ∧ j = 2 ∧ k = 0 then 1
  else if i = 2 ∧ j = 0 ∧ k = 1 then 1
  else if i = 0 ∧ j = 2 ∧ k = 1 then -1
  else if i = 2 ∧ j = 1 ∧ k = 0 then -1
  else if i = 1 ∧ j = 0 ∧ k = 2 then -1
  else 0

/-- `ε` is invariant under cyclic permutations: `ε_{abc} = ε_{cab}`. -/
theorem eps_cyclic (a b c : Fin 3) : eps a b c = eps c a b := by
  fin_cases a <;> fin_cases b <;> fin_cases c <;> simp [eps]

/-- `ε` is antisymmetric under swapping the first two indices: `ε_{abc} = -ε_{bac}`. -/
theorem eps_swap (a b c : Fin 3) : eps a b c = -eps b a c := by
  fin_cases a <;> fin_cases b <;> fin_cases c <;> simp [eps]

/-- **Trace orthonormality of the Pauli generators.**  `tr(σ_a σ_b) = 2 δ_{ab}`. -/
theorem pauli_trace_orthonormal (a b : Fin 3) :
    (pauliV a * pauliV b).trace = 2 * (if a = b then 1 else 0) := by
  fin_cases a <;> fin_cases b <;>
    simp [pauliV, pauli1, pauli2, pauli3, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.diag] <;> norm_num

set_option maxHeartbeats 800000 in
-- 27 (3×3×3) case split over explicit Pauli matrices, each with a small `norm_num`.
/-- **Trace of a triple product of Pauli matrices.**  `tr(σ_a σ_b σ_c) = 2 i ε_{abc}`. -/
theorem pauli_triple_trace (a b c : Fin 3) :
    (pauliV a * pauliV b * pauliV c).trace = 2 * Complex.I * eps a b c := by
  fin_cases a <;> fin_cases b <;> fin_cases c <;>
    simp [pauliV, pauli1, pauli2, pauli3, eps, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.diag, Complex.ext_iff] <;> norm_num

set_option maxHeartbeats 800000 in
-- 9 (3×3) case split, each an entrywise 2×2 matrix identity with `norm_num`.
/-- **The `su(2)` commutation relations.**  `[σ_k, σ_l] = 2 i ∑_m ε_{klm} σ_m`. -/
theorem pauli_commutator (k l : Fin 3) :
    pauliV k * pauliV l - pauliV l * pauliV k = (2 * Complex.I) • ∑ m, eps k l m • pauliV m := by
  fin_cases k <;> fin_cases l <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliV, pauli1, pauli2, pauli3, eps,
          Matrix.smul_apply, Complex.ext_iff] <;> norm_num

set_option maxHeartbeats 800000 in
-- 27 (3×3×3) case split over explicit Pauli matrices, each with a small `norm_num`.
/-- Trace of the commutator against a third generator: `tr([σ_k, σ_l] σ_j) = 4 i ε_{klj}`. -/
theorem pauli_commutator_trace (k l j : Fin 3) :
    ((pauliV k * pauliV l - pauliV l * pauliV k) * pauliV j).trace = 4 * Complex.I * eps k l j := by
  fin_cases k <;> fin_cases l <;> fin_cases j <;>
    simp [pauliV, pauli1, pauli2, pauli3, eps, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.diag, Complex.ext_iff] <;> norm_num

/-- The `su(2)`-valued gauge connection `A = ∑_j W^j (σ_j / 2)` from the three real
component fields `W : Fin 3 → ℂ`. -/
noncomputable def connection (W : Fin 3 → ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  ∑ j, W j • ((1 / 2 : ℂ) • pauliV j)

/-- The `su(2)` field strength (curvature) written from the covariant-derivative commutator
`[D_μ, D_ν] = i g (∂_μ W_ν - ∂_ν W_μ)^j (σ_j/2) + (i g)² [A_μ, A_ν]`.  The linear (curl)
part `G_j = ∂_μ W_ν^j - ∂_ν W_μ^j` is given as an abstract input. -/
noncomputable def Fmat (g : ℂ) (G Wμ Wν : Fin 3 → ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  (Complex.I * g) • (∑ j, G j • ((1 / 2 : ℂ) • pauliV j))
    + (Complex.I * g) ^ 2 • (connection Wμ * connection Wν - connection Wν * connection Wμ)

/-- The book's trace projection `-\frac{i}{g}\,\mathrm{tr}(F σ^j)` extracting the `j`-th
field-strength component from an `su(2)`-valued curvature `F`. -/
noncomputable def proj (g : ℂ) (F : Matrix (Fin 2) (Fin 2) ℂ) (j : Fin 3) : ℂ :=
  (-Complex.I / g) * (F * pauliV j).trace

/-- Trace projection of the *linear* part of the curvature returns the curl component:
`tr((∑_m G_m σ_m/2) σ_j) = G_j`. -/
theorem linear_trace (G : Fin 3 → ℂ) (j : Fin 3) :
    ((∑ m, G m • ((1 / 2 : ℂ) • pauliV m)) * pauliV j).trace = G j := by
  simp only [Fin.sum_univ_three, Matrix.smul_mul, smul_smul, Matrix.add_mul, Matrix.trace_add,
    Matrix.trace_smul, smul_eq_mul, pauli_trace_orthonormal]
  fin_cases j <;> simp

set_option maxHeartbeats 1000000 in
-- Distributes the product of two 3-term connection sums, then a 3-way case split on `j`.
/-- Trace projection of the *quadratic* (commutator) part of the curvature returns the
non-abelian term: `tr([A_μ, A_ν] σ_j) = i ∑_{k,l} ε_{klj} W_μ^k W_ν^l`. -/
theorem connection_comm_trace (Wμ Wν : Fin 3 → ℂ) (j : Fin 3) :
    ((connection Wμ * connection Wν - connection Wν * connection Wμ) * pauliV j).trace
      = Complex.I * ∑ k, ∑ l, eps k l j * Wμ k * Wν l := by
  simp only [connection, Fin.sum_univ_three, Matrix.smul_mul, Matrix.mul_smul, smul_smul,
    Matrix.add_mul, Matrix.mul_add, Matrix.sub_mul, Matrix.trace_add, Matrix.trace_sub,
    Matrix.trace_smul, smul_eq_mul, ← mul_assoc, pauli_triple_trace]
  fin_cases j <;> simp [eps] <;> ring

set_option maxHeartbeats 400000 in
-- Assembles the linear and quadratic trace lemmas; `field_simp`/`ring` over `ℂ`.
/-- **The electroweak `SU(2)_L` field strength via the trace projection.**

`-\frac{i}{g}\,\mathrm{tr}(F_{μν}\,σ^j) = (∂_μ W_ν^j - ∂_ν W_μ^j) - g\,ε^{jkl} W_μ^k W_ν^l`,

where `G_j = ∂_μ W_ν^j - ∂_ν W_μ^j` is the curl input and `F_{μν}` is the `su(2)`
curvature `Fmat`.  This is the book's `W_{μν}^j` formula. -/
theorem electroweak_fieldStrength (g : ℂ) (hg : g ≠ 0) (G Wμ Wν : Fin 3 → ℂ) (j : Fin 3) :
    proj g (Fmat g G Wμ Wν) j = G j - g * ∑ k, ∑ l, eps j k l * Wμ k * Wν l := by
  have hsum : ∑ k, ∑ l, eps j k l * Wμ k * Wν l = ∑ k, ∑ l, eps k l j * Wμ k * Wν l :=
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by rw [eps_cyclic k l j]
  have hI4 : Complex.I ^ 4 = 1 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul, Complex.I_sq]; norm_num
  rw [hsum, proj, Fmat, Matrix.add_mul, Matrix.trace_add, Matrix.smul_mul, Matrix.smul_mul,
    Matrix.trace_smul, Matrix.trace_smul, linear_trace, connection_comm_trace]
  simp only [smul_eq_mul]
  field_simp
  ring_nf
  rw [Complex.I_sq, hI4]
  ring

/-- The abelian curvature: a single `U(1)` field `B` along a fixed generator `σ_3` has the
form `i g G (σ_3 / 2)`, with **no quadratic term** because a matrix commutes with itself. -/
noncomputable def abelianFmat (g G : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  (Complex.I * g) • (G • ((1 / 2 : ℂ) • pauliV 2))

/-- **The abelian field strength via the trace projection (`B_{μν} = ∂_μ B_ν - ∂_ν B_μ`).**
Because the `U(1)` connection is a scalar multiple of a single generator, the quadratic
`[A_μ, A_ν]` term vanishes and the trace projection returns the pure curl `G`. -/
theorem abelian_fieldStrength (g G : ℂ) (hg : g ≠ 0) :
    proj g (abelianFmat g G) 2 = G := by
  rw [proj, abelianFmat]
  have h : ((G • ((1 / 2 : ℂ) • pauliV 2)) * pauliV 2).trace = G := by
    have := linear_trace (fun m => if m = 2 then G else 0) 2
    simpa [Fin.sum_univ_three, connection] using this
  rw [Matrix.smul_mul, Matrix.trace_smul, h, smul_eq_mul]
  field_simp
  rw [Complex.I_sq]
  ring

end BookProof.ChapterElectroweakFieldStrength
