import Mathlib
import BookProof.ChapterA3

/-!
# Chapter A, §A.3 — charge conjugation (Lemma 40) and the real Pauli theorem (Prop 37)

This file continues the concrete `4×4` Majorana / gamma-matrix model of
`BookProof/ChapterA3.lean` (work-package **N4** of `FORMALIZATION_ROADMAP.md`,
book §A.3, line 5196), adding the two next deliverables of the queue:

* **Lemma 40 (charge conjugation `Θ`).**  In the Majorana basis, *entrywise
  complex conjugation* `Θ` on `ℂ⁴` is an anti-linear involution commuting with
  every Majorana matrix `iγ^μ` (this is the finite-dimensional instance of the
  C-conjugation of §A.0 Def 8).  Fully concrete — needs no external input,
  because the Majorana matrices are real (`ChapterA3.mgamma_map_conj`).

* **Prop 37 (real Pauli theorem).**  Two real Clifford sets `α^μ`, `β^μ`
  (`4×4` real matrices with `{α^μ,α^ν} = -2 η^{μν}`, same for `β`) are related
  by a **real** matrix `S` with `|det S| = 1`, `β^μ = S α^μ S⁻¹`, unique up to
  sign.  Proved from the **Pauli fundamental theorem** (Note 36, cited
  `Good1955Properties`), introduced as the EXTERNAL named hypothesis
  `PauliFundamental` — never an `axiom`, matching the design of §A.2/§A.3.

  *Proof.*  Complexify: by the fundamental theorem there is an invertible complex
  `T` with `β^μ = T α^μ T⁻¹`, unique up to a nonzero scalar.  Since `α, β` are
  real, entrywise conjugation `T̄` conjugates them the same way, so `T̄ = c·T`
  with `c ≠ 0`; conjugating again gives `c̄ c = 1`, i.e. `|c| = 1`.  Rescale
  `S := a·T` with `a = |det T|^{-1/4} · exp(i·arg c/2)`: then `S` is real
  (`S̄ = S`) and `|det S| = 1`.  Uniqueness up to sign follows from the
  same uniqueness clause applied to two real solutions.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); the sole external input is the named hypothesis
`PauliFundamental`.
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterA3

/-! ## Lemma 40 — charge conjugation `Θ` (entrywise complex conjugation) -/

/-- **Charge conjugation** `Θ` on Majorana spinors `ℂ⁴`: entrywise complex
conjugation (Lemma 40; the finite-dimensional C-conjugation of §A.0 Def 8). -/
def chargeConj (v : Fin 4 → ℂ) : Fin 4 → ℂ := fun i => conj (v i)

/-- `Θ` is an involution. -/
theorem chargeConj_involutive : Function.Involutive chargeConj := by
  intro v; funext i; simp [chargeConj]

/-- `Θ` is additive. -/
theorem chargeConj_add (u v : Fin 4 → ℂ) :
    chargeConj (u + v) = chargeConj u + chargeConj v := by
  funext i; simp [chargeConj]

/-- `Θ` is anti-linear: `Θ (c • v) = c̄ • Θ v`. -/
theorem chargeConj_smul (c : ℂ) (v : Fin 4 → ℂ) :
    chargeConj (c • v) = conj c • chargeConj v := by
  funext i; simp [chargeConj]

/-- **Lemma 40 (commuting).** `Θ` commutes with every Majorana matrix `iγ^μ`. -/
theorem chargeConj_mgamma_commutes (μ : Fin 4) (v : Fin 4 → ℂ) :
    chargeConj (mgamma μ *ᵥ v) = mgamma μ *ᵥ chargeConj v := by
  funext i
  simp only [chargeConj, mulVec, dotProduct, map_sum]
  apply Finset.sum_congr rfl
  intro j _
  rw [map_mul]
  congr 1
  have := congrFun (congrFun (mgamma_map_conj μ) i) j
  simpa [Matrix.map_apply] using this

/-! ## Prop 37 — the real Pauli theorem -/

/-- The Minkowski metric over `ℝ`. -/
def minkowskiR (μ ν : Fin 4) : ℝ := (minkowskiZ μ ν : ℝ)

/-- A **complex Clifford set**: four `4×4` complex matrices satisfying
`{A^μ, A^ν} = -2 η^{μν}`. -/
def IsCliffordC (A : Fin 4 → Matrix (Fin 4) (Fin 4) ℂ) : Prop :=
  ∀ μ ν, A μ * A ν + A ν * A μ = (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ)

/-- A **real Clifford set**: four `4×4` real matrices satisfying
`{A^μ, A^ν} = -2 η^{μν}`. -/
def IsCliffordR (A : Fin 4 → Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  ∀ μ ν, A μ * A ν + A ν * A μ = (-2 * minkowskiR μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℝ)

/-- Complexification of a real matrix (entrywise cast `ℝ → ℂ`). -/
def toC (M : Matrix (Fin 4) (Fin 4) ℝ) : Matrix (Fin 4) (Fin 4) ℂ :=
  M.map (Complex.ofReal)

/-- **Pauli fundamental theorem** (Note 36), taken as an EXTERNAL named
hypothesis (cite `Good1955Properties`; not re-proved).  Two complex Clifford
sets are conjugate by an invertible matrix, unique up to a nonzero scalar. -/
def PauliFundamental : Prop :=
  ∀ (A B : Fin 4 → Matrix (Fin 4) (Fin 4) ℂ), IsCliffordC A → IsCliffordC B →
    (∃ S : Matrix (Fin 4) (Fin 4) ℂ, IsUnit S.det ∧ ∀ μ, B μ = S * A μ * S⁻¹) ∧
    (∀ S T : Matrix (Fin 4) (Fin 4) ℂ, IsUnit S.det → IsUnit T.det →
      (∀ μ, B μ = S * A μ * S⁻¹) → (∀ μ, B μ = T * A μ * T⁻¹) →
      ∃ c : ℂ, c ≠ 0 ∧ T = c • S)

/-! ### Helper lemmas for the complexification bookkeeping -/

/-
The complexification of a real Clifford set is a complex Clifford set.
-/
theorem isCliffordC_toC {A : Fin 4 → Matrix (Fin 4) (Fin 4) ℝ} (hA : IsCliffordR A) :
    IsCliffordC (fun μ => toC (A μ)) := by
  intro μ ν; specialize hA μ ν; simp_all only [neg_mul, neg_smul, ← ext_iff, add_apply, mul_apply,
      neg_apply, smul_apply, smul_eq_mul] ;
  convert hA using 3;
  simp [ ← Complex.ofReal_inj, minkowski, minkowskiR, toC ];
  simp [ Matrix.one_apply ];
  split_ifs <;> norm_num

/-
Complexification is a ring homomorphism on `4×4` matrices: it preserves
products.
-/
theorem toC_mul (M N : Matrix (Fin 4) (Fin 4) ℝ) : toC (M * N) = toC M * toC N := by
  ext i j; simp [ toC, Matrix.mul_apply ] ;

/-
Complexification preserves the identity.
-/
theorem toC_one : toC (1 : Matrix (Fin 4) (Fin 4) ℝ) = 1 := by
  ext i j; by_cases hij : i = j <;> simp [ hij, toC ] ;
  simp [ hij, Matrix.one_apply ]

/-
The determinant of a complexified matrix is the cast of the determinant.
-/
theorem toC_det (M : Matrix (Fin 4) (Fin 4) ℝ) : (toC M).det = (M.det : ℂ) := by
  unfold toC; simp [ Matrix.det_apply' ] ;

/-
Entrywise conjugation fixes a complexified real matrix.
-/
theorem toC_conj (M : Matrix (Fin 4) (Fin 4) ℝ) :
    (toC M).map (starRingEnd ℂ) = toC M := by
  ext i j; simp [toC]

/-
A complex matrix fixed by entrywise conjugation is the complexification of a
real matrix.
-/
theorem exists_real_of_conj_fixed {N : Matrix (Fin 4) (Fin 4) ℂ}
    (hN : N.map (starRingEnd ℂ) = N) : ∃ M : Matrix (Fin 4) (Fin 4) ℝ, toC M = N := by
  use Matrix.of (fun i j => (N i j).re);
  ext i j; simp only [toC, map_apply, of_apply];
  replace hN := congr_fun ( congr_fun hN i ) j; simp_all [ Complex.ext_iff ] ;
  grobner

/-
Complexification is injective.
-/
theorem toC_injective : Function.Injective toC := by
  intro M N h;
  ext i j; have := congr_fun ( congr_fun h i ) j; simp_all [ Complex.ext_iff, toC ] ;

/-
Complexification commutes with the matrix inverse.
-/
theorem toC_inv (M : Matrix (Fin 4) (Fin 4) ℝ) : toC M⁻¹ = (toC M)⁻¹ := by
  by_cases h : IsUnit ( Matrix.det M ) <;> simp_all only [isUnit_iff_ne_zero, ne_eq, inv_def,
      Ring.inverse_eq_inv', Decidable.not_not, not_true_eq_false, not_false_eq_true,
          Ring.inverse_non_unit, zero_smul];
  · ext i j ; simp only [toC, map_apply, smul_apply, smul_eq_mul, Complex.ofReal_mul,
      Complex.ofReal_inv];
    simp only [det_apply', Complex.ofReal_sum, Complex.ofReal_mul, Complex.ofReal_intCast,
      Complex.ofReal_prod, adjugate_apply, map_apply, mul_eq_mul_left_iff, inv_eq_zero];
    simp only [updateRow_apply, Pi.single_apply, map_apply];
    exact Or.inl ( Finset.sum_congr rfl fun _ _ => by congr; ext; aesop );
  · simp_all [ toC, Matrix.det_apply' ];
    norm_cast at * ; aesop

/-
**Prop 37 (real Pauli theorem).**  Two real Clifford sets `α^μ`, `β^μ` are
related by a real matrix `S` with `|det S| = 1`, `β^μ = S α^μ S⁻¹`, unique up to
sign.
-/
set_option maxHeartbeats 2000000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
theorem real_pauli (hpf : PauliFundamental)
    (α β : Fin 4 → Matrix (Fin 4) (Fin 4) ℝ)
    (hα : IsCliffordR α) (hβ : IsCliffordR β) :
    ∃ S : Matrix (Fin 4) (Fin 4) ℝ, |S.det| = 1 ∧ (∀ μ, β μ = S * α μ * S⁻¹) ∧
    (∀ S' : Matrix (Fin 4) (Fin 4) ℝ, |S'.det| = 1 → (∀ μ, β μ = S' * α μ * S'⁻¹) →
      S' = S ∨ S' = -S) := by
  -- Let `Aμ := toC (α μ)`, `Bμ := toC (β μ)`, complex Clifford sets by `isCliffordC_toC`.
  set A : Fin 4 → Matrix (Fin 4) (Fin 4) ℂ := fun μ => toC (α μ)
  set B : Fin 4 → Matrix (Fin 4) (Fin 4) ℂ := fun μ => toC (β μ);
  -- By the Pauli fundamental theorem, there exists a complex matrix T such that B μ = T * A μ * T⁻¹
  -- for all μ.
  obtain ⟨T, hT⟩ : ∃ T : Matrix (Fin 4) (Fin 4) ℂ, IsUnit T.det ∧ ∀ μ, B μ = T * A μ * T⁻¹ := by
    exact hpf A B ( isCliffordC_toC hα ) ( isCliffordC_toC hβ ) |>.1;
  -- Let `Tc := T.map (starRingEnd ℂ)`. Apply `.map (starRingEnd ℂ)` to the intertwining relation;
  -- using `toC_conj` (α,β real) and that entrywise conjugation is a ring hom commuting with inverse
  -- (`(T⁻¹).map conj = (T.map conj)⁻¹`, provable via `Matrix.inv_eq_left_inv` + `← Matrix.map_mul`
  -- + `Matrix.nonsing_inv_mul`), get `∀ μ, toC (β μ) = Tc * toC (α μ) * Tc⁻¹`. Also `IsUnit Tc.det`
  -- since `Tc.det = conj T.det`.
  obtain ⟨c, hc⟩ : ∃ c : ℂ, c ≠ 0 ∧ T.map (starRingEnd ℂ) = c • T := by
    apply (hpf A B (isCliffordC_toC hα) (isCliffordC_toC hβ)).2 T (T.map (starRingEnd ℂ)) hT.1 (by
    convert hT.1.map ( starRingEnd ℂ ) using 1;
    simp [ Matrix.det_apply' ]) (by
    exact hT.2) (by
    intro μ
    have hTc : B μ = (T.map (starRingEnd ℂ)) * A μ * (T.map (starRingEnd ℂ))⁻¹ := by
      have hTc_eq : (T.map (starRingEnd ℂ)) * A μ * (T.map (starRingEnd ℂ))⁻¹ = (T * A μ * T⁻¹).map
          (starRingEnd ℂ) := by
        have hTc_eq : (T.map (starRingEnd ℂ))⁻¹ = (T⁻¹).map (starRingEnd ℂ) := by
          rw [ Matrix.inv_eq_left_inv ];
          rw [ ← Matrix.map_mul ];
          ext i j ; by_cases hi : i = j <;> aesop;
        simp only [hTc_eq, Matrix.map_mul];
        exact congr_arg₂ _ ( congr_arg₂ _ rfl ( by ext i j; exact (by
        exact Eq.symm ( by exact (by
          have := toC_conj (α μ);
          exact (by
          exact congr_fun ( congr_fun this i ) j)) )) ) ) rfl
      rw [ hTc_eq, ← hT.2 μ, toC_conj ];
    exact hTc);
  -- Let `r : ℝ := ‖T.det‖ ^ (-1/4 : ℝ)` (positive, `T.det ≠ 0`), `w := Complex.exp ((c.arg/2:ℝ) •
  -- I)` with `w^2 = c`, `‖w‖ = 1`, `conj w = w⁻¹`. Let `a := (r:ℂ) * w`, `S0 := a • T` (note `a ≠
  -- 0`).
  obtain ⟨r, w, a, S0, hr, hw, ha, hS0⟩ : ∃ r : ℝ,    ∃ w : ℂ,    ∃ a : ℂ,    ∃ S0 : Matrix (Fin 4)
      (Fin 4) ℂ,    r > 0 ∧ w^2 = c ∧ ‖w‖ = 1 ∧ a = r * w ∧ S0 = a • T ∧ S0.map (starRingEnd ℂ) = S0
          ∧ ‖S0.det‖ = 1 := by
    -- Let `r : ℝ := ‖T.det‖ ^ (-1/4 : ℝ)` (positive, `T.det ≠ 0`), `w := Complex.exp ((c.arg/2:ℝ) •
    -- I)` with `w^2 = c`, `‖w‖ = 1`, `conj w = w⁻¹`. Let `a := (r:ℂ) * w`, `S0 := a • T` (note `a ≠
    -- 0`), and verify the properties.
    obtain ⟨r, hr⟩ : ∃ r : ℝ, r > 0 ∧ r^4 = 1 / ‖T.det‖ := by
      exact ⟨ ( 1 / ‖T.det‖ ) ^ ( 1/4 : ℝ ), Real.rpow_pos_of_pos ( one_div_pos.mpr (
          norm_pos_iff.mpr ( show T.det ≠ 0 from hT.1.ne_zero ) ) ) _,
              by rw [ ← Real.rpow_natCast, ← Real.rpow_mul ( one_div_nonneg.mpr ( norm_nonneg _ ) )
                  ] ; norm_num ⟩
    obtain ⟨w, hw⟩ : ∃ w : ℂ, w^2 = c ∧ ‖w‖ = 1 := by
      have hw : ‖c‖ = 1 := by
        have h_det : Matrix.det (T.map (starRingEnd ℂ)) = starRingEnd ℂ (Matrix.det T) := by
          simp [ Matrix.det_apply' ];
        replace h_det := congr_arg Norm.norm h_det ; simp_all [ pow_eq_one_iff_of_nonneg ];
      exact ⟨ c ^ ( 1 / 2 : ℂ ), by rw [ ← Complex.cpow_nat_mul ] ; norm_num,
                                    by rw [ Complex.norm_cpow_of_ne_zero hc.1 ] ; norm_num [ hw ] ⟩
    use r, w, r * w, (r * w) • T;
    simp_all only [isUnit_iff_ne_zero, ne_eq, gt_iff_lt, one_div, det_smul_of_tower,
        Fintype.card_fin, mul_pow, smul_eq_mul, Complex.norm_mul, norm_pow, Complex.norm_real,
            Real.norm_eq_abs, abs_of_pos hr.1, one_pow, mul_one, norm_eq_zero, not_false_eq_true,
                inv_mul_cancel₀, and_true, true_and];
    ext i j; simp only [mul_comm, map_apply, smul_apply, smul_eq_mul, mul_left_comm, map_mul,
        Complex.conj_ofReal] ;
    replace hc := congr_fun ( congr_fun hc.2 i ) j;      simp_all only [mul_assoc, map_apply,
                                                           smul_apply,
                                                           smul_eq_mul,
                                                           mul_comm,
                                                           mul_left_comm] ;
    rw [ ← hw.1 ] ; ring;
    rw [ show w ^ 2 = w * w by ring, mul_assoc ] ; rw [ show ( starRingEnd ℂ ) w = w⁻¹ from ?_ ] ;
                               focus (ring);
    · grind;
    · rw [ Complex.inv_def, Complex.normSq_eq_norm_sq ] ; aesop;
  -- By `exists_real_of_conj_fixed` get real `S` with `toC S = S0`.
  obtain ⟨S, hS⟩ : ∃ S : Matrix (Fin 4) (Fin 4) ℝ, toC S = S0 := by
    exact exists_real_of_conj_fixed hS0.2.2.1;
  refine ⟨ S, ?_, ?_, ?_ ⟩;
  · convert hS0.2.2.2 using 1;
    rw [ ← hS, toC_det ] ; norm_cast;
  · intro μ
    have h_inter : B μ = S0 * A μ * S0⁻¹ := by
      simp_all [ Matrix.inv_def ];
      simp [ Matrix.adjugate_smul, smul_smul, mul_assoc, mul_comm ];
      simp [ show (w * r) ^ 4 = (w * r) ^ 3 * (w * r) by ring, mul_assoc,
        mul_left_comm, hr.ne', show w ≠ 0 from by aesop_cat ];
      simp [ mul_left_comm ( w : ℂ ), hr.ne', show w ≠ 0 from by aesop_cat ];
    refine toC_injective ?_;
    convert h_inter using 1;
    rw [ ← hS, toC_mul, toC_mul, toC_inv ];
  · intro S' hS' hS'_eq
    obtain ⟨d, hd⟩ : ∃ d : ℂ, d ≠ 0 ∧ toC S' = d • toC S := by
      have h_conj : ∀ μ, toC (β μ) = toC S' * toC (α μ) * (toC S')⁻¹ := by
        intro μ; rw [ hS'_eq μ ] ; simp [ toC_mul, toC_inv ] ;
      have := hpf A B ( isCliffordC_toC hα ) ( isCliffordC_toC hβ );
      apply this.right;
      · simp_all ;
        exact ⟨ hr.ne', by rintro rfl; norm_num at ha ⟩;
      · rw [ toC_det ];
        exact isUnit_iff_ne_zero.mpr ( by aesop_cat );
      · intro μ; specialize hT; have := hT.2 μ; simp_all [ Matrix.mul_assoc ] ;
        simp [ Matrix.inv_def, Matrix.smul_eq_diagonal_mul ];
        simp [ ← mul_assoc, ← Matrix.smul_eq_diagonal_mul, Matrix.adjugate_smul ];
        simp [ ← smul_assoc, ← mul_assoc, 
           ];
        field_simp;
        rw [show (r * w / (T.det * r * w)) = (1 / T.det) by
          rw [div_eq_div_iff] <;> ring <;> norm_num [hr.ne', show w ≠ 0 from by aesop_cat,
            hT.1]];
      · exact h_conj;
    -- Since `toC S' = d • toC S`, we have `S' = d • S`.
    have hS'_eq_dS : S' = d.re • S := by
      ext i j; simp only [ne_eq, toC] at hd; (
      replace hd := congr_fun ( congr_fun hd.2 i ) j; simp_all [ Complex.ext_iff ] ;);
    have h_det_S : |S.det| = 1 := by
      have h_det_S : ‖(toC S).det‖ = 1 := by
        grind;
      convert h_det_S using 1;
      norm_num [ toC_det ];
    simp_all only [isUnit_iff_ne_zero, ne_eq, gt_iff_lt, det_smul_of_tower, Fintype.card_fin,
        smul_eq_mul, abs_mul, abs_pow, mul_one, Algebra.smul_mul_assoc];
    rcases eq_or_eq_neg_of_abs_eq
      (show |d.re| = 1 by
        rw [pow_eq_one_iff_of_nonneg (abs_nonneg _)] at hS' <;> aesop) with h | h <;>
      aesop

/-! ## Prop 46 — the metric-preservation core (`Λ(S) ∈ O(1,3)`) -/

/-- The Minkowski metric as a `4×4` real matrix `η = diag(1,-1,-1,-1)`. -/
def minkowskiMat : Matrix (Fin 4) (Fin 4) ℝ := Matrix.of (fun μ ν => minkowskiR μ ν)

/-
**Prop 46 (metric preservation).**  If `S` is invertible and the real matrix
`Λ` describes the conjugation action of `S` on the Majorana basis,
`S⁻¹ (iγ^μ) S = Σ_ν Λ^μ_ν (iγ^ν)`, then `Λ` is a Lorentz transformation:
`Λ η Λᵀ = η`.  This is the computational heart of Prop 46 (that
`Λ : Pin(3,1) → O(1,3)`), following from the Clifford relation
`{iγ^μ, iγ^ν} = -2 η^{μν}`.
-/
theorem lorentz_of_conj (S : Matrix (Fin 4) (Fin 4) ℂ) (hS : IsUnit S.det)
    (Lam : Matrix (Fin 4) (Fin 4) ℝ)
    (hLam : ∀ μ, S⁻¹ * mgamma μ * S = ∑ ν, (Lam μ ν : ℂ) • mgamma ν) :
    Lam * minkowskiMat * Lamᵀ = minkowskiMat := by
  -- By equating the two expressions for `P`, we can conclude that the sums are equal.
  have hP_eq : ∀ (μ ν : Fin 4),    (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) = ∑ α,    ∑
      β, ((Lam μ α : ℂ) * (Lam ν β : ℂ)) • ((mgamma α * mgamma β + mgamma β * mgamma α)) := by
    intro μ ν
    have hP_eq : (S⁻¹ * mgamma μ * S) * (S⁻¹ * mgamma ν * S) + (S⁻¹ * mgamma ν * S) * (S⁻¹ * mgamma
        μ * S) = (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
      simp_all only [isUnit_iff_ne_zero, ne_eq, mul_assoc, Complex.coe_smul, neg_mul, neg_smul];
      simp_all only [← hLam, implies_true, mul_assoc, isUnit_iff_ne_zero, ne_eq, not_false_eq_true,
          mul_nonsing_inv_cancel_left];
      convert congr_arg ( fun x => S⁻¹ * x * S ) ( mgamma_clifford μ ν ) using 1 <;> simp [
          mul_assoc, hS, isUnit_iff_ne_zero ];
      simp only [Matrix.add_mul, mul_assoc, Matrix.mul_add];
    rw [ ← hP_eq, hLam, hLam ];
    simp only [Complex.coe_smul, Finset.mul_sum _ _ _, Algebra.mul_smul_comm, Finset.sum_mul,
        Algebra.smul_mul_assoc, smul_add, Finset.sum_add_distrib];
    simp only [Finset.smul_sum, smul_smul, mul_comm];
    exact congrArg₂ ( · + · ) ( Finset.sum_comm.trans ( Finset.sum_congr rfl fun _ _ =>
                            Finset.sum_congr rfl fun _ _ => by norm_cast ) ) ( Finset.sum_congr rfl
                                                               fun _ _ => Finset.sum_congr rfl fun _
                                                                   _ => by norm_cast );
  -- By equating the two expressions for `P`, we can conclude that the sums are equal. Use the fact
  -- that `mgamma_clifford` holds.
  have hP_eq' : ∀ (μ ν : Fin 4),    (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) = (-2 * ∑
      α, ∑ β, (Lam μ α : ℂ) * (minkowskiR α β) * (Lam ν β : ℂ)) • (1 : Matrix (Fin 4) (Fin 4) ℂ) :=
          by
    intro μ ν;      rw [ hP_eq μ ν ] ;      simp [ mgamma_clifford, Finset.mul_sum _ _ _,
        mul_left_comm, mul_comm ] ; ring;
    simp [ Finset.sum_smul, smul_smul, mul_assoc, mul_comm, mul_left_comm, minkowski, minkowskiR ];
  ext μ ν; specialize hP_eq' μ ν; simp_all only [isUnit_iff_ne_zero, ne_eq, Complex.coe_smul, ←
      ext_iff, neg_mul, neg_smul, smul_add, neg_apply, smul_apply, smul_eq_mul, neg_inj,
          one_ne_zero, not_false_eq_true, smul_left_inj, mul_eq_mul_left_iff, OfNat.ofNat_ne_zero,
              or_false] ;
  convert congr_arg Complex.re hP_eq'.symm using 1 ;    norm_num [ Complex.ext_iff, Matrix.mul_apply
      ] ; ring;
  simp only [minkowskiMat, Finset.sum_mul _ _ _];
  exact Finset.sum_comm.trans ( Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
      by ring! )

end BookProof.ChapterA3
