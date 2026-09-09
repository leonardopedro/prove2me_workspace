import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3b

/-!
# Chapter A, §A.3 — the group homomorphism `Λ : Pin(3,1) → O(1,3)` (Prop 46, group form)

This file completes work-package **N4**'s **Prop 46** of `FORMALIZATION_ROADMAP.md`
(book §A.3, line 5196): the *group-theoretic wrapper* of the metric-preservation
core `lorentz_of_conj` proved in `BookProof/ChapterA3b.lean`.

Working entirely over `ℝ` (the Majorana matrices `iγ^μ` have integer, hence real,
entries — `mgammaR`), we build:

* `LorentzO` — the Lorentz group `O(1,3) = {Λ | Λ η Λᵀ = η}`.
* `HasLambda S Λ` — the predicate that the real matrix `Λ` describes the
  conjugation action of `S` on the Majorana basis:
  `S⁻¹ (iγ^μ) S = Σ_ν Λ^μ_ν (iγ^ν)`.
* `IsPin S` — membership in `Pin(3,1)`: `|det S| = 1` and the conjugation action
  lands in `Maj = span_ℝ{iγ^μ}` (i.e. some `Λ` exists).
* `LambdaOf S` — the (well-defined, by linear independence `mgammaR_indep`)
  Lorentz matrix `Λ(S)`.

and prove the three headline properties of Prop 46:

* **Lands in `O(1,3)`** (`lambda_mem_lorentz`) — directly from `lorentz_of_conj`.
* **Homomorphism** (`lambdaOf_mul`) — `Λ(S₁ S₂) = Λ(S₁) Λ(S₂)`.
* **2-to-1 surjective** (`lambda_surjective`, `lambda_two_to_one`) — via the real
  Pauli theorem `real_pauli`; the fibre of `Λ` over any `λ ∈ O(1,3)` is exactly
  `{±S}`.

The only external input is the named hypothesis `PauliFundamental` (Note 36),
inherited from `ChapterA3b.real_pauli`; there is no `axiom`.
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterA3

/-! ## The real Majorana matrices -/

/-- The four Majorana matrices `iγ^μ` as **real** `4×4` matrices (integer model
cast into `ℝ`). -/
noncomputable def mgammaR (μ : Fin 4) : Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix (mgammaZ μ)

/-
The complexification of the real Majorana matrix is the complex one.
-/
theorem toC_mgammaR (μ : Fin 4) : toC (mgammaR μ) = mgamma μ := by
  unfold toC mgammaR mgamma; ext i j; fin_cases μ <;> fin_cases i <;> fin_cases j <;> rfl;

/-
The real Majorana matrices form a real Clifford set.
-/
theorem mgammaR_clifford : IsCliffordR mgammaR := by
  intro μ ν;
  convert congr_arg ( fun m : Matrix ( Fin 4 ) ( Fin 4 ) ℤ => ( Int.castRingHom ℝ ).mapMatrix m ) (
      mgammaZ_clifford μ ν ) using 1;
  · ext i j ; simp [ Matrix.mul_apply, Matrix.add_apply ] ; ring;
    rfl;
  · ext i j ; by_cases hij : i = j <;> simp only [minkowskiR, minkowskiZ, Fin.isValue,
      Int.reduceNeg, Int.cast_ite, Int.cast_one, Int.cast_neg, Int.cast_zero, mul_ite, mul_one,
          mul_neg, neg_neg, mul_zero, hij, smul_apply, one_apply_eq, smul_eq_mul, ite_smul,
              neg_smul, zsmul_eq_mul, Int.cast_ofNat, zero_smul, RingHom.mapMatrix_apply,
                  Int.coe_castRingHom, map_apply, ne_eq, not_false_eq_true, one_apply_ne];
    · fin_cases μ <;> fin_cases ν <;> simp only [Fin.zero_eta, Fin.isValue, ↓reduceIte, neg_apply,
        Int.cast_neg, neg_inj, Fin.mk_one, zero_ne_one, zero_apply, Int.cast_zero, Fin.reduceFinMk,
            Fin.reduceEq, one_ne_zero] ; all_goals fin_cases j <;> norm_cast;
    · fin_cases i <;> fin_cases j <;> simp at hij ⊢;
      all_goals split_ifs <;> norm_num;
      all_goals norm_cast;

/-
**Linear independence of the Majorana basis.**  The four matrices `iγ^μ` are
`ℝ`-linearly independent, so a Lorentz matrix `Λ` describing the conjugation
action is unique.
-/
theorem mgammaR_indep (c : Fin 4 → ℝ) (h : ∑ ν, c ν • mgammaR ν = 0) :
    ∀ ν, c ν = 0 := by
  unfold mgammaR at h;
  simp_all [ Fin.sum_univ_four, Fin.forall_fin_succ ];
  unfold mgammaZ at h; simp_all [ ← Matrix.ext_iff, Fin.forall_fin_succ ] ;
  constructor <;> linarith

/-! ## The Lorentz group and the map `Λ` -/

/-- The Lorentz group `O(1,3) = {Λ ∈ Matrix (Fin 4) (Fin 4) ℝ | Λ η Λᵀ = η}`. -/
def LorentzO : Set (Matrix (Fin 4) (Fin 4) ℝ) :=
  {Λ | Λ * minkowskiMat * Λᵀ = minkowskiMat}

/-- `HasLambda S Λ`: the real matrix `Λ` describes the conjugation action of `S`
on the Majorana basis, `S⁻¹ (iγ^μ) S = Σ_ν Λ^μ_ν (iγ^ν)`. -/
def HasLambda (S Λ : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  ∀ μ, S⁻¹ * mgammaR μ * S = ∑ ν, Λ μ ν • mgammaR ν

/-- Membership in `Pin(3,1)`: `S` is invertible with `|det S| = 1` and its
conjugation action on the Majorana basis lands in `Maj = span_ℝ{iγ^μ}`. -/
def IsPin (S : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  IsUnit S.det ∧ |S.det| = 1 ∧ ∃ Λ, HasLambda S Λ

open Classical in
/-- The Lorentz matrix `Λ(S)` associated to `S` (junk `0` when `S ∉ Pin(3,1)`). -/
noncomputable def LambdaOf (S : Matrix (Fin 4) (Fin 4) ℝ) :
    Matrix (Fin 4) (Fin 4) ℝ :=
  if h : ∃ Λ, HasLambda S Λ then h.choose else 0

/-- The chosen `Λ(S)` indeed describes the conjugation action, when one exists. -/
theorem hasLambda_LambdaOf (S : Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∃ Λ, HasLambda S Λ) : HasLambda S (LambdaOf S) := by
  have : LambdaOf S = h.choose := by rw [LambdaOf, dif_pos h]
  rw [this]; exact h.choose_spec

/-
**Uniqueness of `Λ`** (from linear independence of the Majorana basis).
-/
theorem hasLambda_unique {S Λ Λ' : Matrix (Fin 4) (Fin 4) ℝ}
    (h : HasLambda S Λ) (h' : HasLambda S Λ') : Λ = Λ' := by
  ext μ ν; have := h μ; have := h' μ; simp_all only [HasLambda, implies_true] ;
  have h_eq : ∀ μ, ∑ ν, (Λ μ ν - Λ' μ ν) • mgammaR ν = 0 := by
    simp_all [ sub_smul, Finset.sum_sub_distrib ];
  exact sub_eq_zero.mp ( mgammaR_indep _ ( h_eq μ ) ν )

/-! ## Prop 46(a) — `Λ(S)` lands in `O(1,3)` -/

/-
**Real form of `lorentz_of_conj`.**  If `S` is invertible and `HasLambda S Λ`,
then `Λ ∈ O(1,3)`.
-/
theorem lorentz_of_conjR (S : Matrix (Fin 4) (Fin 4) ℝ) (hS : IsUnit S.det)
    (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : HasLambda S Λ) :
    Λ * minkowskiMat * Λᵀ = minkowskiMat := by
  convert lorentz_of_conj ( toC S ) _ Λ _ using 1;
  · rw [ toC_det ];
    exact IsUnit.map ( algebraMap ℝ ℂ ) hS;
  · intro μ; specialize hΛ μ; simp_all only [isUnit_iff_ne_zero, ne_eq, ← toC_inv, Complex.coe_smul]
      ;
    convert congr_arg ( fun x : Matrix ( Fin 4 ) ( Fin 4 ) ℝ => toC x ) hΛ using 1;
    · simp [ toC_mul, toC_inv, toC_mgammaR ];
    · ext i j; simp [ toC, mgammaR ] ;
      simp [ Matrix.sum_apply, mgamma ]

/-- `Λ(S) ∈ O(1,3)` for every `S ∈ Pin(3,1)`. -/
theorem lambda_mem_lorentz (S : Matrix (Fin 4) (Fin 4) ℝ) (hS : IsPin S) :
    LambdaOf S ∈ LorentzO :=
  lorentz_of_conjR S hS.1 _ (hasLambda_LambdaOf S hS.2.2)

/-! ## Prop 46(b) — `Λ` is a homomorphism -/

/-
`HasLambda` composes: if `S₁, S₂` are invertible with `HasLambda S₁ Λ₁` and
`HasLambda S₂ Λ₂`, then `HasLambda (S₁ S₂) (Λ₁ Λ₂)`.
-/
theorem hasLambda_mul {S₁ S₂ Λ₁ Λ₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (_h1 : IsUnit S₁.det) (_h2 : IsUnit S₂.det)
    (hL1 : HasLambda S₁ Λ₁) (hL2 : HasLambda S₂ Λ₂) :
    HasLambda (S₁ * S₂) (Λ₁ * Λ₂) := by
  intro μ;
  simp_all only [isUnit_iff_ne_zero, ne_eq, Matrix.mul_inv_rev, mul_assoc];
  convert congr_arg ( fun x => S₂⁻¹ * x * S₂ ) ( hL1 μ ) using 1 <;> simp only [← mul_assoc,
                                                                       Matrix.mul_sum,
                                                                       Algebra.mul_smul_comm,
                                                                       Matrix.sum_mul,
                                                                       Algebra.smul_mul_assoc];
  simp only [mul_apply];
  simp only [Finset.sum_smul];
  rw [ Finset.sum_comm ];
  exact Finset.sum_congr rfl fun _ _ => by rw [ hL2 ] ;    simp [ Finset.smul_sum, smul_smul ] ;

/-
`Pin(3,1)` is closed under multiplication.
-/
theorem isPin_mul {S₁ S₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : IsPin S₁) (h2 : IsPin S₂) : IsPin (S₁ * S₂) := by
  -- Show that the determinant of the product is 1.
  have h_det : IsUnit (S₁ * S₂).det ∧ |(S₁ * S₂).det| = 1 := by
    simp_all [ IsPin ]
  generalize_proofs at *;
  exact ⟨ h_det.1, h_det.2, by obtain ⟨ Λ₁, hL1 ⟩ := h1.2.2; obtain ⟨ Λ₂, hL2 ⟩ := h2.2.2; exact ⟨
                               Λ₁ * Λ₂, hasLambda_mul h1.1 h2.1 hL1 hL2 ⟩ ⟩

/-- **Prop 46 (homomorphism).** `Λ(S₁ S₂) = Λ(S₁) Λ(S₂)`. -/
theorem lambdaOf_mul {S₁ S₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : IsPin S₁) (h2 : IsPin S₂) :
    LambdaOf (S₁ * S₂) = LambdaOf S₁ * LambdaOf S₂ := by
  apply hasLambda_unique (hasLambda_LambdaOf _ (isPin_mul h1 h2).2.2)
  exact hasLambda_mul h1.1 h2.1 (hasLambda_LambdaOf _ h1.2.2) (hasLambda_LambdaOf _ h2.2.2)

/-! ## Prop 46(c) — `Λ` is 2-to-1 surjective -/

/-
The Majorana-basis combination `β^μ = Σ_ν Λ^μ_ν (iγ^ν)` of a Lorentz matrix
`Λ` is again a real Clifford set.
-/
theorem cliffordR_lorentz_comb (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : Λ ∈ LorentzO) :
    IsCliffordR (fun μ => ∑ ν, Λ μ ν • mgammaR ν) := by
  intro μ ν;
  -- By definition of matrix multiplication and the properties of the Majorana matrices, we can
  -- expand the products.
  have h_expand : (∑ α, Λ μ α • mgammaR α) * (∑ β, Λ ν β • mgammaR β) +
      (∑ β, Λ ν β • mgammaR β) * (∑ α, Λ μ α • mgammaR α) =
      ∑ α, ∑ β, (Λ μ α * Λ ν β) • (mgammaR α * mgammaR β + mgammaR β * mgammaR α) := by
        simp only [Finset.mul_sum _ _ _, mul_smul_comm, Finset.sum_mul, smul_mul_assoc, smul_add];
        simp only [Finset.smul_sum, smul_smul, mul_comm, Finset.sum_add_distrib];
        rw [ Finset.sum_comm ];
  -- By definition of matrix multiplication and the properties of the Majorana matrices, we can
  -- simplify the expression.
  have h_simplify : ∑ α, ∑ β, (Λ μ α * Λ ν β) • (mgammaR α * mgammaR β + mgammaR β * mgammaR α) =
      ∑ α, ∑ β, (Λ μ α * Λ ν β) • ((-2 * minkowskiR α β) • 1) := by
        exact Finset.sum_congr rfl fun i hi => Finset.sum_congr rfl fun j hj =>
            by rw [ mgammaR_clifford i j ] ;
  -- By definition of matrix multiplication and the properties of the Minkowski metric, we can
  -- simplify the expression.
  have h_final : ∑ α, ∑ β, (Λ μ α * Λ ν β) • (-2 * minkowskiR α β) • (1 : Matrix (Fin 4) (Fin 4) ℝ)
      =
      (-2 * (Λ * minkowskiMat * Λᵀ) μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
        simp only [neg_mul, neg_smul, smul_neg, Finset.sum_neg_distrib, mul_apply, transpose_apply,
            Finset.sum_mul, mul_assoc, Finset.mul_sum _ _ _, mul_left_comm, mul_neg, neg_inj];
        simp only [minkowskiMat, of_apply, mul_comm, mul_left_comm, Finset.sum_smul];
        exact Finset.sum_comm.trans ( Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _
            => by simp [ mul_assoc, smul_smul ] );
  exact h_expand.trans <| h_simplify.trans <| h_final.trans <| by rw [ hΛ ] ; rfl;

/-
`-S` is again in `Pin(3,1)` with the same Lorentz image.
-/
theorem hasLambda_neg {S Λ : Matrix (Fin 4) (Fin 4) ℝ} (h : HasLambda S Λ) :
    HasLambda (-S) Λ := by
  intro μ; specialize h μ; simp_all only [inv_def, Ring.inverse_eq_inv', Algebra.smul_mul_assoc,
      mul_neg] ;
  simp_all only [det_neg, Fintype.card_fin, _root_.mul_inv_rev];
  convert h using 1;
  rw [ show ( -S ).adjugate = ( -1 ) ^ 3 • S.adjugate from ?_ ] ; focus (norm_num [ pow_succ ]);
  convert Matrix.adjugate_smul ( -1 : ℝ ) S using 1 ; focus (norm_num);
  norm_num [ Fintype.card_fin ]

theorem isPin_neg {S : Matrix (Fin 4) (Fin 4) ℝ} (h : IsPin S) : IsPin (-S) := by
  refine ⟨ ?_, ?_, ?_ ⟩;
  · rw [ Matrix.det_neg ];
    exact IsUnit.mul ( isUnit_one.neg.pow _ ) h.1;
  · convert h.2.1 using 1;
    norm_num [ Matrix.det_neg ];
  · exact ⟨ _, hasLambda_neg ( h.2.2.choose_spec ) ⟩

theorem lambdaOf_neg {S : Matrix (Fin 4) (Fin 4) ℝ} (h : IsPin S) :
    LambdaOf (-S) = LambdaOf S := by
  apply hasLambda_unique (hasLambda_LambdaOf _ (isPin_neg h).2.2)
  exact hasLambda_neg (hasLambda_LambdaOf _ h.2.2)

/-
**Prop 46 (surjectivity).** Every `Λ ∈ O(1,3)` is `Λ(S)` for some
`S ∈ Pin(3,1)`.  (Uses the real Pauli theorem, hence the named hypothesis
`PauliFundamental`.)
-/
theorem lambda_surjective (hpf : PauliFundamental)
    (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : Λ ∈ LorentzO) :
    ∃ S : Matrix (Fin 4) (Fin 4) ℝ, IsPin S ∧ LambdaOf S = Λ := by
  have := @cliffordR_lorentz_comb Λ hΛ;
  obtain ⟨S, hS⟩ : ∃ S : Matrix (Fin 4) (Fin 4) ℝ,    |S.det| = 1 ∧ (∀ μ, mgammaR μ = S * (∑ ν, Λ μ
      ν • mgammaR ν) * S⁻¹) := by
    have := @real_pauli hpf ( fun μ => ∑ ν, Λ μ ν • mgammaR ν ) mgammaR this mgammaR_clifford;
    exact ⟨ this.choose, this.choose_spec.1, this.choose_spec.2.1 ⟩;
  refine ⟨ S, ⟨ ?_, hS.1, ?_ ⟩, ?_ ⟩;
  · exact isUnit_iff_ne_zero.mpr ( by intro h; norm_num [ h ] at hS );
  · use Λ;
    intro μ;
    rw [ hS.2 μ ];
    simp [ ← mul_assoc, show S.det ≠ 0 from by intro h; simp [ h ] at hS ];
  · apply hasLambda_unique;
    focus (apply hasLambda_LambdaOf);
    · use Λ;
      intro μ;
      rw [ hS.2 μ ];
      simp [ ← mul_assoc, show S.det ≠ 0 from by intro h; simp [ h ] at hS ];
    · intro μ;
      rw [ hS.2 μ ];
      simp [ ← mul_assoc, show S.det ≠ 0 from by intro h; norm_num [ h ] at hS ]

/-
**Prop 46 (2-to-1).** Two Pin elements with the same Lorentz image differ by a
sign: the fibre of `Λ` over any `λ ∈ O(1,3)` is exactly `{±S}`.
-/
theorem lambda_two_to_one (hpf : PauliFundamental)
    {S S' : Matrix (Fin 4) (Fin 4) ℝ} (hS : IsPin S) (hS' : IsPin S')
    (h : LambdaOf S = LambdaOf S') : S' = S ∨ S' = -S := by
  have h_conj : ∀ μ, S⁻¹ * mgammaR μ * S = ∑ ν, (LambdaOf S) μ ν • mgammaR ν ∧
      S'⁻¹ * mgammaR μ * S' = ∑ ν, (LambdaOf S') μ ν • mgammaR ν :=
    fun μ => ⟨hasLambda_LambdaOf S hS.2.2 μ, hasLambda_LambdaOf S' hS'.2.2 μ⟩
  have h_conj_eq : ∀ μ, mgammaR μ = S * (∑ ν, (LambdaOf S) μ ν • mgammaR ν) * S⁻¹ ∧
      mgammaR μ = S' * (∑ ν, (LambdaOf S') μ ν • mgammaR ν) * S'⁻¹ := by
    simp [← h_conj, mul_assoc, hS.1.ne_zero, hS'.1.ne_zero]
  have hβcliff := cliffordR_lorentz_comb (LambdaOf S) (lambda_mem_lorentz S hS)
  obtain ⟨S₀, hS₀₁, hS₀₂, hS₀₃⟩ :=
    real_pauli hpf (fun μ => ∑ ν, (LambdaOf S) μ ν • mgammaR ν) mgammaR hβcliff mgammaR_clifford
  cases hS₀₃ S hS.2.1 (fun μ => by simpa [h] using h_conj_eq μ |>.1) <;>
    cases hS₀₃ S' hS'.2.1 (fun μ => by simpa [h] using h_conj_eq μ |>.2) <;>
    simp_all +singlePass

end BookProof.ChapterA3
