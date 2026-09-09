import Mathlib
import BookProof.ChapterParity

/-!
# Chapter "On the physical parity transformation and antiparticles" — the Higgs is a
real representation (pseudoreal ⊗ pseudoreal = real)

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model"), begun in `ChapterParity` / `ChapterParityQL`.

The chapter's central physical thesis is that at the quantum level **all fields are real
representations** of the symmetry group.  For the electroweak Higgs doublet `φ` this is the
Majorana-type reality ("pseudoreality") condition quoted in the chapter,

  `i σ₂ φ = i τ₂ φ*`,

where `σ₂` is the custodial `SU(2)` Pauli matrix and `τ₂` is the gauge `SU(2)_L` Pauli
matrix.  Because `σ₂` and `τ₂` act on **different** doublet indices, the reality condition
is realized on the tensor product `ℂ² ⊗ ℂ²` by the antilinear operator

  `C(φ) = (τ₂ ⊗ σ₂) φ*`.

The mathematical content is the classical representation-theoretic fact that

  **a tensor product of two quaternionic (pseudoreal) structures is a real structure.**

A single `SU(2)` doublet is *pseudoreal*: the antilinear operator `C₀(φ) = σ₂ φ*` squares
to `-1` (it is a quaternionic structure, so a single doublet carries **no** real
structure).  But the *bidoublet* `τ₂ ⊗ σ₂` squares to `+1`, i.e. it is a genuine **real
structure** (an antilinear involution) — which is exactly why the Higgs *is* a real
representation, even though neither factor alone is.

## Contents

* `realityOp M` — the antilinear operator `v ↦ M *ᵥ v*`, and `realityOp_realityOp`:
  `C_M ∘ C_M = (M · M*) *ᵥ ·`, so `C_M` is an involution (real structure) iff
  `M · M* = 1` and squares to `-1` (quaternionic structure) iff `M · M* = -1`.
* `pauli2_map_conj` : `σ₂* = -σ₂`; `pauli2_pseudoreal` : `σ₂ · σ₂* = -1` — a single
  doublet is pseudoreal (`higgsDoublet_pseudoreal` : `C₀² = -1`).
* `kronecker_map_conj` : entrywise conjugation distributes over the Kronecker product.
* `pseudoreal_kron_pseudoreal_real` : the general statement — if `A·A* = -1` and
  `B·B* = -1` then `(A⊗B)·(A⊗B)* = 1`.
* `higgsReal := σ₂ ⊗ σ₂`; `higgsReal_mul_conj` : `(τ₂⊗σ₂)·(τ₂⊗σ₂)* = 1`, and the headline
  `higgs_real_structure` : `C ∘ C = id`, so the Higgs bidoublet carries a real structure —
  the Higgs is a real representation.

The surrounding physical modelling (the full Standard-Model Lagrangian, the custodial
symmetry) is left as prose.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped Kronecker
open scoped ComplexConjugate

namespace BookProof.ChapterParityHiggs

open BookProof.ChapterParity

/-! ## 1. The antilinear reality operator and its square -/

/-- The antilinear "reality" operator `C_M(v) = M *ᵥ v*` (matrix `M` times the entrywise
complex conjugate of `v`).  A *real structure* is such a `C_M` with `C_M ∘ C_M = id`; a
*quaternionic (pseudoreal) structure* is one with `C_M ∘ C_M = -id`. -/
noncomputable def realityOp {I : Type*} [Fintype I] [DecidableEq I]
    (M : Matrix I I ℂ) (v : I → ℂ) : I → ℂ :=
  M *ᵥ (fun i => conj (v i))

/-- **Square of the reality operator.**  Applying `C_M` twice multiplies by the matrix
`M · M*` (where `M*` is the entrywise conjugate):

  `C_M (C_M v) = (M · M*) *ᵥ v`.

Hence `C_M` is an involution (a real structure) iff `M · M* = 1`, and `C_M² = -id`
(a quaternionic structure) iff `M · M* = -1`. -/
theorem realityOp_realityOp {I : Type*} [Fintype I] [DecidableEq I]
    (M : Matrix I I ℂ) (v : I → ℂ) :
    realityOp M (realityOp M v) = (M * M.map (starRingEnd ℂ)) *ᵥ v := by
  rw [← Matrix.mulVec_mulVec]
  unfold realityOp
  congr 1
  ext j
  simp only [Matrix.mulVec, dotProduct, Matrix.map_apply, map_sum, map_mul, Complex.conj_conj]

/-! ## 2. A single `SU(2)` doublet is pseudoreal -/

/-- Entrywise conjugation negates `σ₂`: `σ₂* = -σ₂`. -/
theorem pauli2_map_conj : pauli2.map (starRingEnd ℂ) = -pauli2 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [pauli2, Matrix.map_apply, Complex.conj_I]

/-- **A single doublet is pseudoreal (quaternionic).**  `σ₂ · σ₂* = -1`. -/
theorem pauli2_pseudoreal : pauli2 * (pauli2.map (starRingEnd ℂ)) = -1 := by
  rw [pauli2_map_conj, Matrix.mul_neg, pauli2_sq]

/-- The reality operator of a single `SU(2)` doublet squares to `-id`: `C₀(C₀ φ) = -φ`.
A single Higgs doublet carries a *quaternionic* structure and hence **no** real
structure — it is pseudoreal. -/
theorem higgsDoublet_pseudoreal (v : Fin 2 → ℂ) :
    realityOp pauli2 (realityOp pauli2 v) = -v := by
  rw [realityOp_realityOp, pauli2_pseudoreal]
  ext i; simp [Matrix.mulVec, dotProduct, Matrix.one_apply]

/-! ## 3. Pseudoreal ⊗ pseudoreal = real (the general statement) -/

/-- Entrywise complex conjugation distributes over the Kronecker product. -/
theorem kronecker_map_conj {l m n p : Type*} (A : Matrix l m ℂ) (B : Matrix n p ℂ) :
    (A ⊗ₖ B).map (starRingEnd ℂ)
      = (A.map (starRingEnd ℂ)) ⊗ₖ (B.map (starRingEnd ℂ)) := by
  ext i j
  simp [Matrix.kroneckerMap_apply, Matrix.map_apply, map_mul]

/-- **A tensor product of two quaternionic (pseudoreal) structures is a real structure.**
If `A · A* = -1` and `B · B* = -1`, then `(A ⊗ B) · (A ⊗ B)* = 1`.  The two `-1`s multiply
to `+1`, so the antilinear operator `C_{A⊗B}` is an involution. -/
theorem pseudoreal_kron_pseudoreal_real
    {m n : Type*} [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n]
    (A : Matrix m m ℂ) (B : Matrix n n ℂ)
    (hA : A * A.map (starRingEnd ℂ) = -1) (hB : B * B.map (starRingEnd ℂ) = -1) :
    (A ⊗ₖ B) * ((A ⊗ₖ B).map (starRingEnd ℂ)) = 1 := by
  rw [kronecker_map_conj, ← Matrix.mul_kronecker_mul, hA, hB,
      show (-1 : Matrix m m ℂ) = (-1 : ℂ) • 1 from by simp,
      show (-1 : Matrix n n ℂ) = (-1 : ℂ) • 1 from by simp,
      Matrix.smul_kronecker, Matrix.kronecker_smul, Matrix.one_kronecker_one, smul_smul]
  norm_num

/-! ## 4. The Higgs bidoublet carries a real structure -/

/-- The internal operator `τ₂ ⊗ σ₂` of the Higgs Majorana condition `iσ₂ φ = iτ₂ φ*`,
acting on the bidoublet `ℂ² ⊗ ℂ² ≅ ℂ⁴`.  Both factors are the Pauli matrix `σ₂`
(`τ₂ = σ₂` as matrices), acting on distinct doublet indices. -/
noncomputable def higgsReal : Matrix (Fin 2 × Fin 2) (Fin 2 × Fin 2) ℂ := pauli2 ⊗ₖ pauli2

/-- **The Higgs bidoublet is real.**  `(τ₂ ⊗ σ₂) · (τ₂ ⊗ σ₂)* = 1`: the tensor product of
the two pseudoreal doublet structures is a real structure. -/
theorem higgsReal_mul_conj : higgsReal * (higgsReal.map (starRingEnd ℂ)) = 1 :=
  pseudoreal_kron_pseudoreal_real pauli2 pauli2 pauli2_pseudoreal pauli2_pseudoreal

/-- **The Higgs is a real representation.**  The antilinear operator `C(φ) = (τ₂ ⊗ σ₂) φ*`
implementing the Majorana condition `iσ₂ φ = iτ₂ φ*` is an involution: `C(C φ) = φ`.  Thus
the bidoublet carries a genuine real structure, even though each `SU(2)` doublet factor is
only pseudoreal (`higgsDoublet_pseudoreal`). -/
theorem higgs_real_structure (v : Fin 2 × Fin 2 → ℂ) :
    realityOp higgsReal (realityOp higgsReal v) = v := by
  rw [realityOp_realityOp, higgsReal_mul_conj]
  ext i; simp [Matrix.mulVec, dotProduct, Matrix.one_apply]

end BookProof.ChapterParityHiggs
