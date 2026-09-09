import Mathlib

/-!
# Chapter — Diffeomorphisms and gravity: the irreducible decomposition of a spatial tensor

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"* (line ~8091).  In the Einstein–Cartan / teleparallel Hamiltonian
formalism the author decomposes the *spatial* torsion tensor `T_{ab}` (both free
indices projected by the spatial projector `χ` of Wave 69, so it lives on the
`3`-dimensional spatial hyperplane `v^⊥`) into three irreducible pieces relative
to the rotation group `SO(3)` of the spatial slice:

* the **antisymmetric part** `A_{ab} = T_{ab} − T_{ba}` (the book's `A_{ab}`);
* the **trace** `T = η^{ab} T_{ab}` (the book's scalar `T`);
* the **symmetric traceless part**
  `S_{ab} = T_{ab} + T_{ba} − (2/3) η_{ab} T` (the book's `S_{ab}`).

Since these tensors are fully spatial, and the induced spatial metric restricted
to `v^⊥` is positive definite (Wave 70), we model the spatial slice as the
Euclidean `3`-space `Fin 3` with `η_{ab} = δ_{ab}`.  The `2/3` factor is exactly
the one that makes `S` traceless *in three dimensions* (`tr δ = 3`), matching the
book.

This file makes the self-contained linear-algebra content precise.  A spatial
tensor is a `3 × 3` real matrix `M` (the book's `T_{ab}`), and we prove:

* `antisymPart_antisymm` — `A` is antisymmetric (`Aᵀ = −A`);
* `symTracelessPart_symm` — `S` is symmetric (`Sᵀ = S`);
* `trace_symTracelessPart` — `S` is traceless (`tr S = 0`);
* `irrep_reconstruction` — **headline**: the three pieces reassemble `M`,
  `M = ½ S + ½ A + ⅓ (tr M) · I`;
* `frob_symTraceless_antisym`, `frob_symTraceless_trace`, `frob_antisym_trace` —
  the three pieces are mutually orthogonal for the Frobenius inner product
  `⟨X, Y⟩ = ∑_{i,j} X_{ij} Y_{ij}`, i.e. the decomposition is orthogonal.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravityIrrep

open Matrix
open scoped BigOperators

/-- The **antisymmetric part** `A_{ab} = T_{ab} − T_{ba}` (the book's `A_{ab}`). -/
noncomputable def antisymPart (M : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  M - Mᵀ

/-- The **symmetric traceless part** `S_{ab} = T_{ab} + T_{ba} − (2/3) η_{ab} T`
(the book's `S_{ab}`), with `η_{ab} = δ_{ab}` on the Euclidean spatial slice. -/
noncomputable def symTracelessPart (M : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  M + Mᵀ - (2 / 3 * M.trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ)

/-- The Frobenius inner product `⟨X, Y⟩ = ∑_{i,j} X_{ij} Y_{ij}` on spatial
tensors. -/
noncomputable def frobInner (X Y : Matrix (Fin 3) (Fin 3) ℝ) : ℝ :=
  ∑ i, ∑ j, X i j * Y i j

/-- `A` is antisymmetric: `Aᵀ = −A`. -/
theorem antisymPart_antisymm (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (antisymPart M)ᵀ = -(antisymPart M) := by
  simp [antisymPart, transpose_sub, transpose_transpose]

/-- `S` is symmetric: `Sᵀ = S`. -/
theorem symTracelessPart_symm (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (symTracelessPart M)ᵀ = symTracelessPart M := by
  simp [symTracelessPart, transpose_sub, transpose_add, transpose_transpose, transpose_smul,
    Matrix.transpose_one]
  abel

/-- `S` is traceless: `tr S = 0` (this is where the `2/3` factor and `dim = 3`
enter). -/
theorem trace_symTracelessPart (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (symTracelessPart M).trace = 0 := by
  simp [symTracelessPart, Matrix.trace, Matrix.diag, Fin.sum_univ_three]
  ring

/-- **Headline.** The three irreducible pieces reassemble the original spatial
tensor: `M = ½ S + ½ A + ⅓ (tr M) · I`. -/
theorem irrep_reconstruction (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (1 / 2 : ℝ) • symTracelessPart M + (1 / 2 : ℝ) • antisymPart M
      + (1 / 3 : ℝ) • (M.trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ) = M := by
  ext i j
  simp only [symTracelessPart, antisymPart, Matrix.add_apply, Matrix.sub_apply,
    Matrix.smul_apply, Matrix.transpose_apply, smul_eq_mul]
  ring

/-- The symmetric-traceless and antisymmetric pieces are Frobenius-orthogonal. -/
theorem frob_symTraceless_antisym (M : Matrix (Fin 3) (Fin 3) ℝ) :
    frobInner (symTracelessPart M) (antisymPart M) = 0 := by
  simp only [frobInner, symTracelessPart, antisymPart, Matrix.add_apply, Matrix.sub_apply,
    Matrix.smul_apply, Matrix.transpose_apply, Matrix.one_apply, smul_eq_mul,
    Fin.sum_univ_three]
  norm_num [Fin.ext_iff]
  ring

/-- The symmetric-traceless piece is Frobenius-orthogonal to the trace piece. -/
theorem frob_symTraceless_trace (M : Matrix (Fin 3) (Fin 3) ℝ) :
    frobInner (symTracelessPart M) ((M.trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) = 0 := by
  simp only [frobInner, symTracelessPart, Matrix.add_apply, Matrix.sub_apply,
    Matrix.smul_apply, Matrix.transpose_apply, Matrix.one_apply, smul_eq_mul, Matrix.trace,
    Matrix.diag, Fin.sum_univ_three]
  norm_num [Fin.ext_iff]
  ring

/-- The antisymmetric piece is Frobenius-orthogonal to the trace piece. -/
theorem frob_antisym_trace (M : Matrix (Fin 3) (Fin 3) ℝ) :
    frobInner (antisymPart M) ((M.trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) = 0 := by
  simp only [frobInner, antisymPart, Matrix.sub_apply,
    Matrix.smul_apply, Matrix.transpose_apply, Matrix.one_apply, smul_eq_mul,
    Fin.sum_univ_three]
  norm_num [Fin.ext_iff]

end BookProof.ChapterGravityIrrep
