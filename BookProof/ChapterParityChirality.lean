import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterParity
import BookProof.ChapterParitySU2

/-!
# Chapter "On the physical parity transformation and antiparticles" — the chirality
projector in the left-handed quark doublet `Q_L`

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model"), begun in `ChapterParity`/`ChapterParityQL`/`ChapterParitySU2`.

The chapter states that the left-handed quark doublet `Q_L` — a Majorana (real) spinor
carrying **both** an `SU(2)_L` doublet index and a Majorana spinor index — satisfies the
chirality/projection constraint

  `i γ⁵ Q_L = i σ₃ Q_L`,

with the `SU(2)_L` factor `i σ₃` acting on the doublet index (`ℂ²`) and the internal
`U(1)_Y`/chirality generator `i γ⁵ = mgamma5` acting on the spinor index (`ℂ⁴`).  A
footnote then uses "the **projector in `Q_L`**" to halve the count of the
`SU(2)_L`-invariant Yukawa products (the `4` custodial matrices `{1, iσⱼ}` of
`ChapterParityCustodial` "divided by `2`", leaving `2` independent products).

On `ℂ² ⊗ ℂ⁴ ≅ ℂ⁸`, write `iσ₃ = (iσ₃)⊗1` (`isigma3`) and `iγ⁵ = 1⊗(iγ⁵)` (`igamma5`).
Both square to `-1` and commute, their product being the **chirality operator**
`χ = (iσ₃)⊗(iγ⁵)` (`chi`).  This file proves:

* `isigma3_sq`, `igamma5_sq`: `(iσ₃)² = (iγ⁵)² = -1` (from `pauli3² = 1`, `(iγ⁵)² = -1`);
* `isigma3_igamma5`, `igamma5_isigma3`: `iσ₃` and `iγ⁵` commute, both products equalling `χ`;
* `chi_sq`: `χ² = 1` — `χ` is an involution, so its eigenvalues are `±1`;
* `chi_trace`: `tr χ = 0` — the two eigenspaces have equal dimension (`4` and `4`), the
  "divide by `2`" of the footnote;
* `QLProj` `= ½(1 - χ)`, the projector onto the `Q_L` chirality subspace, with
  `QLProj_idem` (`P² = P`) and `QLProj_trace` (`tr P = 4`, half of `dim = 8`);
* `chirality_iff`: the book's constraint `iσ₃ Q_L = iγ⁵ Q_L` is equivalent to
  `χ Q_L = -Q_L`;
* `chirality_iff_proj`: equivalently, `Q_L` lies in the range of the projector,
  `P Q_L = Q_L`.

The surrounding physical modelling (the full Standard-Model Yukawa Lagrangian and the
`SU(2)_L × (SU(3)_C × U(1)_Y) ⋊ ℤ₄` background symmetry) is left as prose.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped Kronecker

namespace BookProof.ChapterParityChirality

open BookProof.ChapterA3
open BookProof.ChapterParity
open BookProof.ChapterParitySU2

/-- `iσ₃` acting on the `SU(2)_L` doublet index, extended to `ℂ²⊗ℂ⁴` as `(iσ₃)⊗1`. -/
noncomputable def isigma3 : Matrix (Fin 2 × Fin 4) (Fin 2 × Fin 4) ℂ :=
  (Complex.I • pauli3) ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)

/-- `iγ⁵` acting on the Majorana spinor index, extended to `ℂ²⊗ℂ⁴` as `1⊗(iγ⁵)`. -/
noncomputable def igamma5 : Matrix (Fin 2 × Fin 4) (Fin 2 × Fin 4) ℂ :=
  (1 : Matrix (Fin 2) (Fin 2) ℂ) ⊗ₖ mgamma5

/-- The **chirality operator** `χ = (iσ₃)⊗(iγ⁵)` on `ℂ²⊗ℂ⁴ ≅ ℂ⁸`. -/
noncomputable def chi : Matrix (Fin 2 × Fin 4) (Fin 2 × Fin 4) ℂ :=
  (Complex.I • pauli3) ⊗ₖ mgamma5

/--
`(iσ₃)² = -1`: the `SU(2)_L` doublet chirality generator squares to `-1`
(`σ₃² = 1`, `i² = -1`).
-/
theorem isigma3_sq : isigma3 * isigma3 = -1 := by
  ext ⟨ i, j ⟩ ⟨ k, l ⟩ ; norm_num [ isigma3 ];
  fin_cases i <;> fin_cases k <;> simp only [kroneckerMap, smul_apply, smul_eq_mul, Fin.zero_eta,
      Fin.isValue, mul_apply, of_apply, Fin.mk_one, ne_eq, Prod.mk.injEq, zero_ne_one, false_and,
          not_false_eq_true, one_apply_ne, neg_zero, one_ne_zero];
  · fin_cases j <;> fin_cases l <;> simp only [Fin.isValue, one_apply, Fin.zero_eta, mul_ite,
      mul_one, mul_zero, ite_mul, zero_mul, Fin.mk_one, Prod.mk.injEq, zero_ne_one, and_false,
          Fin.reduceFinMk, Fin.reduceEq, one_ne_zero];
    all_goals erw [ Finset.sum_product ] ; simp [ Fin.sum_univ_succ, pauli3 ] ;
  · fin_cases j <;> fin_cases l <;> simp only [pauli3, Fin.isValue, of_apply, cons_val',
      cons_val_fin_one, cons_val_zero, cons_val_one];
    all_goals erw [ Finset.sum_product ] ; simp [ Fin.sum_univ_succ, Matrix.one_apply ] ;
  · fin_cases j <;> fin_cases l <;> simp only [pauli3, Fin.isValue, of_apply, cons_val',
      cons_val_fin_one, cons_val_one, cons_val_zero];
    all_goals erw [ Finset.sum_product ] ; simp [ Fin.sum_univ_succ, Matrix.one_apply ] ;
  · fin_cases j <;> fin_cases l <;> simp only [pauli3, Fin.isValue, of_apply, cons_val',
      cons_val_fin_one, cons_val_one, one_apply, Fin.zero_eta, mul_ite, mul_one, mul_zero, ite_mul,
          zero_mul, Fin.mk_one, Prod.mk.injEq, zero_ne_one, and_false, Fin.reduceFinMk,
              Fin.reduceEq, one_ne_zero];
    all_goals erw [ Finset.sum_product ] ; simp [ Fin.sum_univ_succ ] ;

/--
`(iγ⁵)² = -1`: the internal spinor chirality generator squares to `-1`.
-/
theorem igamma5_sq : igamma5 * igamma5 = -1 := by
  unfold igamma5;
  convert congr_arg ( fun x => kroneckerMap ( fun x1 x2 => x1 * x2 ) ( 1 : Matrix ( Fin 2 ) ( Fin 2
      ) ℂ ) x ) BookProof.ChapterA3.mgamma5_sq using 1;
  · ext i j;
    simp only [kroneckerMap, mul_apply, of_apply];
    simp only [one_apply, ite_mul, one_mul, zero_mul, mul_ite, mul_zero, Finset.sum_ite,
        Finset.sum_const_zero, add_zero];
    split_ifs <;> simp_all only [Finset.sum_filter, ↓reduceIte, ite_self, Finset.sum_const_zero];
    rw [ ← Finset.sum_filter ];
    refine Finset.sum_bij ( fun x hx => x.2 ) ?_ ?_ ?_ ?_ <;> aesop;
  · ext i j ; fin_cases i <;> fin_cases j <;> norm_num

/--
`iσ₃` and `iγ⁵` commute, their product being the chirality operator `χ`.
-/
theorem isigma3_igamma5 : isigma3 * igamma5 = chi := by
  convert Matrix.mul_kronecker_mul ( Complex.I • pauli3 ) 1 1 mgamma5;
  all_goals try exact ⟨ 1 ⟩;
  · ext ⟨ i, j ⟩ ⟨ k, l ⟩ ; simp only [isigma3, igamma5, mul_one, one_mul, kroneckerMap_apply,
      smul_apply, smul_eq_mul];
    simp only [kroneckerMap, smul_apply, smul_eq_mul, mul_apply, of_apply];
    simp only [one_apply, mul_ite, mul_one, mul_zero, ite_mul, one_mul, zero_mul, Finset.sum_ite,
        Finset.sum_const_zero, add_zero];
    rw [ Finset.sum_eq_single ( k, j ) ] <;> aesop;
  · convert Matrix.mul_kronecker_mul ( Complex.I • pauli3 ) 1 1 mgamma5;
    unfold chi; aesop;

/--
`iσ₃` and `iγ⁵` commute, their product being the chirality operator `χ`.
-/
theorem igamma5_isigma3 : igamma5 * isigma3 = chi := by
  ext ⟨ i, j ⟩ ⟨ k, l ⟩ ; simp only [igamma5, isigma3, mul_apply, kroneckerMap_apply, smul_apply,
      smul_eq_mul, chi];
  simp only [one_apply, ite_mul, one_mul, zero_mul, mul_comm, mul_left_comm, mul_ite, mul_zero,
      ite_self];
  rw [ Finset.sum_eq_single ( i, l ) ] <;> aesop

/--
`χ² = 1`: the chirality operator is an involution, so its eigenvalues are `±1`.
-/
theorem chi_sq : chi * chi = 1 := by
  have hp3 : pauli3 * pauli3 = 1 := by
    ext i j
    fin_cases i <;> fin_cases j <;> simp [pauli3, Matrix.mul_apply, Fin.sum_univ_two]
  have hp : (Complex.I • pauli3) * (Complex.I • pauli3) = -1 := by
    rw [Matrix.smul_mul, Matrix.mul_smul, hp3, smul_smul, Complex.I_mul_I]
    simp
  rw [chi, ← Matrix.mul_kronecker_mul, hp, BookProof.ChapterA3.mgamma5_sq]
  ext ⟨i, j⟩ ⟨k, l⟩
  simp [Matrix.one_apply, Matrix.kroneckerMap, Prod.ext_iff]
  by_cases h : i = k <;> by_cases h2 : j = l <;> simp [h, h2]

/--
`tr χ = 0`: the `±1` eigenspaces of the chirality operator have equal dimension
(`4` each), the "divide by `2`" of the chapter's Yukawa-counting footnote.
-/
theorem chi_trace : chi.trace = 0 := by
  unfold chi;
  unfold mgamma5;
  unfold mgamma5Z pauli3; norm_num [ Fin.sum_univ_succ, Matrix.trace ] ;
  erw [ Finset.sum_product ] ; norm_num [ Fin.sum_univ_succ ]

/-- The **`Q_L` chirality projector** `P = ½(1 - χ)` onto the `χ = -1` eigenspace, i.e. the
subspace where the chapter's constraint `iσ₃ Q_L = iγ⁵ Q_L` holds. -/
noncomputable def QLProj : Matrix (Fin 2 × Fin 4) (Fin 2 × Fin 4) ℂ :=
  (2 : ℂ)⁻¹ • (1 - chi)

/--
`P² = P`: the `Q_L` chirality operator `P = ½(1 - χ)` is idempotent (a projector),
using `χ² = 1`.
-/
theorem QLProj_idem : QLProj * QLProj = QLProj := by
  have hexp : (1 - chi) * (1 - chi) = (2 : ℂ) • (1 - chi) := by
    have h : (1 - chi) * (1 - chi) = 1 - chi - chi + chi * chi := by noncomm_ring
    rw [h, chi_sq]; module
  rw [QLProj, Matrix.smul_mul, Matrix.mul_smul, hexp, smul_smul, smul_smul]
  norm_num

/--
`tr P = 4`: the `Q_L` chirality projector has rank `4`, exactly half of the ambient
dimension `8 = dim(ℂ²⊗ℂ⁴)` — the "divide by `2`" of the chapter's footnote.
-/
theorem QLProj_trace : QLProj.trace = 4 := by
  unfold QLProj;
  norm_num [ Matrix.trace_sub, chi_trace ]

/--
**The chapter's chirality constraint.**  `i σ₃ Q_L = i γ⁵ Q_L` is equivalent to
`Q_L` being a `(-1)`-eigenvector of the chirality operator `χ = (iσ₃)⊗(iγ⁵)`.
-/
theorem chirality_iff (v : Fin 2 × Fin 4 → ℂ) :
    isigma3 *ᵥ v = igamma5 *ᵥ v ↔ chi *ᵥ v = -v := by
  constructor
  · intro h
    have hh := congr_arg (fun w => igamma5 *ᵥ w) h
    simp only at hh
    rw [Matrix.mulVec_mulVec, igamma5_isigma3, Matrix.mulVec_mulVec, igamma5_sq,
      Matrix.neg_mulVec, Matrix.one_mulVec] at hh
    exact hh
  · intro h
    have hh := congr_arg (fun w => isigma3 *ᵥ w) h
    simp only at hh
    rw [Matrix.mulVec_mulVec, ← isigma3_igamma5, ← Matrix.mul_assoc, isigma3_sq,
      neg_one_mul, Matrix.neg_mulVec, Matrix.mulVec_neg] at hh
    exact (neg_injective hh).symm

/-- The chirality constraint holds iff `Q_L` lies in the range of the projector `P`,
`P Q_L = Q_L`. -/
theorem chirality_iff_proj (v : Fin 2 × Fin 4 → ℂ) :
    chi *ᵥ v = -v ↔ QLProj *ᵥ v = v := by
  have hsub : QLProj *ᵥ v = (1 / 2 : ℂ) • (v - chi *ᵥ v) := by
    simp [QLProj, Matrix.sub_mulVec, Matrix.smul_mulVec]
  constructor
  · intro h
    exact hsub.trans (by ext; norm_num [h]; ring)
  · intro hv
    rw [hsub] at hv
    have hc : v - chi *ᵥ v = (2 : ℂ) • v := by
      have := congr_arg (fun w => (2 : ℂ) • w) hv
      simpa [smul_smul] using this
    funext i
    have := congr_fun hc i
    simp only [Pi.sub_apply, Pi.smul_apply, Pi.neg_apply, smul_eq_mul] at this ⊢
    linear_combination -this

end BookProof.ChapterParityChirality
