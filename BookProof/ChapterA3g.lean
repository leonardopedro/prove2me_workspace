import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3c
import BookProof.ChapterA3e
import BookProof.ChapterA3f

/-!
# Chapter A.3 (g): the infinitesimal → group bridge of Note 47 / Lemma 48

This module completes the **group-level** half of Note 47 / Lemma 48 of §A.3
(work-package **N4**) by discharging the two analytic ingredients recorded as the
standing obstruction in `ChapterA3e.lean`:

* the **adjoint-exponential identity** `exp(-G)·X·exp(G) = exp(-ad_G)(X)`
  (`conj_exp_hasAdLambda`), specialised to the Majorana basis: if
  `HasAdLambda G A` (the commutator `[G, iγ^μ]` is described by the real matrix
  `A`), then conjugation by `exp G` expands in the Majorana basis with matrix
  `exp(-A)`;
* the **Lie-algebra → group exponential** `A ∈ 𝔬(1,3) ⟹ exp A ∈ O(1,3)`
  (`lorentzLie_exp`).

The adjoint-exponential identity is proved by the classical one-parameter ODE
argument, staying entirely inside `Matrix (Fin 4) (Fin 4) ℝ` (no operator
exponential): the function `φ(t) = exp(t•G) · Z(t) · exp(-t•G)`, with
`Z(t) = Σ_ν (exp(-t•A))^μ_ν iγ^ν`, has zero derivative because
`Z'(t) = -[G, Z(t)]`, hence is constant `= iγ^μ`; unwinding at `t = 1` gives
`exp(-G) iγ^μ exp(G) = Σ_ν (exp(-A))^μ_ν iγ^ν`.

Combining with `ChapterA3f.spinLie_det_exp_eq_one` (`det (exp G) = 1`) and
`ChapterA3e.spinLie_hasAdLambda_lorentzLie`, we obtain the group-level
statements:

* `hasLambda_exp` — `HasLambda (exp G) (exp (-A))`;
* `isPin_exp_of_isSpinLie` — `exp G ∈ Pin(3,1)` for `G ∈ 𝔰𝔭𝔦𝔫⁺(3,1)`;
* `spinLie_exp_hasLambda_lorentz` — the Lorentz image `Λ(exp G) = exp(-A)` lies
  in `O(1,3)`.
-/

open Matrix
open scoped Norms.Operator

namespace BookProof.ChapterA3

variable {G A : Matrix (Fin 4) (Fin 4) ℝ}

/-! ## The matrix exponential is invertible with inverse `exp (-G)` -/

/-- `exp(-G)` is a two-sided inverse of `exp G`. -/
theorem exp_neg_mul_exp (G : Matrix (Fin 4) (Fin 4) ℝ) :
    NormedSpace.exp (-G) * NormedSpace.exp G = 1 := by
  rw [← NormedSpace.exp_add_of_commute (Commute.neg_left (Commute.refl G)), neg_add_cancel,
    NormedSpace.exp_zero]

/-- The (matrix) inverse of `exp G` is `exp (-G)`. -/
theorem exp_matrix_inv (G : Matrix (Fin 4) (Fin 4) ℝ) :
    (NormedSpace.exp G)⁻¹ = NormedSpace.exp (-G) :=
  Matrix.inv_eq_left_inv (exp_neg_mul_exp G)

/-! ## The adjoint-exponential identity -/

/-
**Adjoint-exponential identity (Majorana form).**  If `HasAdLambda G A`, then
conjugation of the Majorana matrix `iγ^μ` by `exp G` expands in the Majorana
basis with matrix `exp(-A)`:
`exp(-G) · iγ^μ · exp(G) = Σ_ν (exp(-A))^μ_ν iγ^ν`.
-/
theorem conj_exp_hasAdLambda (h : HasAdLambda G A) (μ : Fin 4) :
    NormedSpace.exp (-G) * mgammaR μ * NormedSpace.exp G
      = ∑ ν, (NormedSpace.exp (-A)) μ ν • mgammaR ν := by
  -- By definition of $Z$, we know that its derivative is $-(G * Z t - Z t * G)$.
  have hZ_deriv : ∀ t : ℝ,    HasDerivAt (fun t => ∑ ν, (NormedSpace.exp (t • (-A))) μ ν • mgammaR
      ν) (-(G * (∑ ν, (NormedSpace.exp (t • (-A))) μ ν • mgammaR ν) - (∑ ν, (NormedSpace.exp (t •
          (-A))) μ ν • mgammaR ν) * G)) t := by
    intro t
    have hZ_deriv_step : HasDerivAt (fun t => ∑ ν, (NormedSpace.exp (t • (-A))) μ ν • mgammaR ν) (∑
        ν, ((-A) * NormedSpace.exp (t • (-A))) μ ν • mgammaR ν) t := by
      have hZ_deriv : ∀ ν,        HasDerivAt (fun t => (NormedSpace.exp (t • (-A))) μ ν) ((-A *
          NormedSpace.exp (t • (-A))) μ ν) t := by
        intro ν
        have h_entry_deriv : HasDerivAt (fun t => (NormedSpace.exp (t • (-A)))) ((-A) *
            (NormedSpace.exp (t • (-A)))) t := by
          convert hasDerivAt_exp_smul_const' ( -A ) t using 1;
        exact hasDerivAt_pi.1 ( hasDerivAt_pi.1 h_entry_deriv μ ) ν;
      convert HasDerivAt.fun_sum fun ν _ => HasDerivAt.smul_const ( hZ_deriv ν ) ( mgammaR ν ) using
          1;
    have h_comm : (-A) * NormedSpace.exp (t • (-A)) = -(NormedSpace.exp (t • (-A)) * A) := by
      have h_comm : Commute A (t • (-A)) := by
        simp [ Commute ];
        simp [ SemiconjBy ];
      have := h_comm.exp_right;
      rw [ neg_mul, this.eq ];
    have h_sum : ∑ ν,      (NormedSpace.exp (t • (-A)) * A) μ ν • mgammaR ν = ∑ ν,
        (NormedSpace.exp (t • (-A))) μ ν • (G * mgammaR ν - mgammaR ν * G) := by
      simp_all only [smul_neg, mul_apply, neg_apply, neg_mul, Finset.sum_neg_distrib, neg_smul,
          neg_inj];
      simp_all only [HasAdLambda, Finset.sum_smul, mul_comm, Finset.smul_sum];
      exact Finset.sum_comm.trans ( Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
          by simp [ mul_comm, smul_smul ] );
    simp_all [ Finset.mul_sum _ _ _, Finset.sum_mul _ _ _, smul_sub ];
  -- By definition of $φ$, we know that its derivative is zero.
  have hφ_deriv : ∀ t : ℝ,    HasDerivAt (fun t => NormedSpace.exp (t • G) * (∑ ν, (NormedSpace.exp
      (t • (-A))) μ ν • mgammaR ν) * NormedSpace.exp (t • (-G))) 0 t := by
    intro t
    have hφ_deriv : HasDerivAt (fun t => NormedSpace.exp (t • G)) (G * NormedSpace.exp (t • G)) t :=
        by
      convert hasDerivAt_exp_smul_const' G t using 1;
    have hφ_deriv : HasDerivAt (fun t => NormedSpace.exp (t • (-G))) ((-G) * NormedSpace.exp (t •
        (-G))) t := by
      convert hasDerivAt_exp_smul_const' ( -G ) t using 1;
    have hφ_deriv : HasDerivAt (fun t => NormedSpace.exp (t • G) * (∑ ν, (NormedSpace.exp (t •
        (-A))) μ ν • mgammaR ν)) (G * NormedSpace.exp (t • G) * (∑ ν, (NormedSpace.exp (t • (-A))) μ
            ν • mgammaR ν) + NormedSpace.exp (t • G) * (-(G * (∑ ν, (NormedSpace.exp (t • (-A))) μ ν
                • mgammaR ν) - (∑ ν, (NormedSpace.exp (t • (-A))) μ ν • mgammaR ν) * G))) t := by
      rename_i h;
      convert HasDerivAt.mul h ( hZ_deriv t ) using 1;
    convert hφ_deriv.mul ‹HasDerivAt ( fun t => NormedSpace.exp ( t • -G ) ) ( -G * NormedSpace.exp
        ( t • -G ) ) t› using 1;
    simp [ mul_sub, sub_mul, add_mul, ← mul_assoc ];
    have h_comm : Commute G (NormedSpace.exp (t • G)) := by
      apply_rules [ Commute.exp_right, Commute.exp_left ];
      exact Commute.smul_right ( Commute.refl G ) t;
    simp [ ← h_comm.eq ];
  -- Since the derivative of $φ$ is zero, $φ$ is constant.
  have hφ_const : ∀ t₁ t₂ : ℝ,    NormedSpace.exp (t₁ • G) * (∑ ν, (NormedSpace.exp (t₁ • (-A))) μ ν
      • mgammaR ν) * NormedSpace.exp (t₁ • (-G)) = NormedSpace.exp (t₂ • G) * (∑ ν, (NormedSpace.exp
          (t₂ • (-A))) μ ν • mgammaR ν) * NormedSpace.exp (t₂ • (-G)) := by
    have hφ_const : ∀ t : ℝ,      deriv (fun t => NormedSpace.exp (t • G) * (∑ ν, (NormedSpace.exp
        (t • (-A))) μ ν • mgammaR ν) * NormedSpace.exp (t • (-G))) t = 0 := by
      intro t;
      convert HasDerivAt.deriv ( hφ_deriv t ) using 1;
    apply_rules [ is_const_of_deriv_eq_zero ];
    exact fun t => ( hφ_deriv t |> HasDerivAt.differentiableAt );
  specialize hφ_const 1 0 ; simp_all only [smul_neg, neg_sub, mul_assoc, one_smul, zero_smul,
      NormedSpace.exp_zero, neg_zero, one_mul, mul_one];
  convert congr_arg ( fun x => NormedSpace.exp ( -G ) * x * NormedSpace.exp G ) hφ_const.symm using
      1 <;> norm_num [ mul_assoc, NormedSpace.exp_add_of_commute, NormedSpace.exp_neg ];
  · simp [ Matrix.one_apply, Finset.sum_ite_eq ];
  · simp [ ← mul_assoc, exp_neg_mul_exp ]

/-- **Group form of the adjoint action.**  `HasLambda (exp G) (exp (-A))` whenever
`HasAdLambda G A`. -/
theorem hasLambda_exp (h : HasAdLambda G A) :
    HasLambda (NormedSpace.exp G) (NormedSpace.exp (-A)) := by
  intro μ
  rw [exp_matrix_inv]
  exact conj_exp_hasAdLambda h μ

/-! ## The Lie-algebra → group exponential -/

/-
**Lie algebra → group.**  If `A ∈ 𝔬(1,3)` then `exp A ∈ O(1,3)`.
-/
theorem lorentzLie_exp (h : A ∈ LorentzLie) :
    NormedSpace.exp A ∈ LorentzO := by
  have h_2 : (Matrix.of minkowskiMat) * A * (Matrix.of minkowskiMat) = -A.transpose := by
    have h_2 : (Matrix.of minkowskiMat) * A * (Matrix.of minkowskiMat) = -A.transpose := by
      have h_mul : A * (Matrix.of minkowskiMat) + (Matrix.of minkowskiMat) * A.transpose = 0 := by
        exact h
      convert congr_arg ( fun x => ( Matrix.of minkowskiMat ) * x ) ( eq_neg_of_add_eq_zero_left
          h_mul ) using 1 ; focus (simp [ Matrix.mul_assoc ]);
      ext i j; simp only [neg_apply, transpose_apply, minkowskiMat, mul_apply, of_apply, mul_neg,
          Finset.sum_neg_distrib, neg_inj] ;
      simp only [minkowskiR, minkowskiZ, Fin.isValue, Int.reduceNeg, Int.cast_ite, Int.cast_one,
          Int.cast_neg, Int.cast_zero, ite_mul, one_mul, neg_mul, zero_mul, Finset.sum_ite_eq,
              Finset.mem_univ, ↓reduceIte, mul_ite, mul_neg];
      fin_cases i <;> fin_cases j <;> simp [ Fin.sum_univ_succ ];
    exact h_2
  have h_3 : NormedSpace.exp ((Matrix.of minkowskiMat) * A * (Matrix.of minkowskiMat)) = (Matrix.of
      minkowskiMat) * NormedSpace.exp A * (Matrix.of minkowskiMat) := by
    convert Matrix.exp_conj ( Matrix.of minkowskiMat ) A _ using 1;
    · rw [ Matrix.inv_eq_left_inv ];
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [ minkowskiMat ] ;
      all_goals simp [ minkowskiR, Matrix.mul_apply ] ;
      all_goals norm_cast;
    · rw [ Matrix.inv_eq_left_inv ];
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [ minkowskiMat ] ;
      all_goals simp [ Matrix.mul_apply, minkowskiR ] ;
      all_goals norm_cast;
    · convert IsUnit.of_mul_eq_one_right _
        ( show ( of minkowskiMat ) * ( of minkowskiMat ) = 1 from ?_ ) using 1;
      ext i j ; fin_cases i <;> fin_cases j <;> simp [ minkowskiMat ];
      all_goals simp [ Matrix.mul_apply, minkowskiR ] ;
      all_goals norm_cast;
  have h_4 : NormedSpace.exp (-A.transpose) = (Matrix.of minkowskiMat) * NormedSpace.exp A *
      (Matrix.of minkowskiMat) := by
    rw [ ← h_2, h_3 ]
  have h_5 : NormedSpace.exp A * (Matrix.of minkowskiMat) * (NormedSpace.exp A).transpose =
      (Matrix.of minkowskiMat) := by
    have h_5 : NormedSpace.exp (-A.transpose) * NormedSpace.exp A.transpose = 1 := by
      convert exp_neg_mul_exp Aᵀ using 1;
    convert congr_arg ( fun x => ( Matrix.of minkowskiMat ) * x ) h_5 using 1 <;>
      norm_num [ h_4, Matrix.mul_assoc ];
    have h_6 : NormedSpace.exp Aᵀ = (NormedSpace.exp A).transpose := by
      convert Matrix.exp_transpose A using 1;
    have h_7 : (Matrix.of minkowskiMat) * (Matrix.of minkowskiMat) = 1 := by
      ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, minkowskiMat ];
      all_goals unfold minkowskiR; norm_num [ Fin.sum_univ_succ, minkowskiZ ] ;
    simp [ ← mul_assoc, h_6, h_7 ]
  exact h_5

/-! ## Group-level Lemma 48 -/

/-- **Group-level Lemma 48 (Pin membership).**  Every element of `𝔰𝔭𝔦𝔫⁺(3,1)`
exponentiates into `Pin(3,1)`. -/
theorem isPin_exp_of_isSpinLie (hG : IsSpinLie G) : IsPin (NormedSpace.exp G) := by
  obtain ⟨A, hA, _hAL⟩ := spinLie_hasAdLambda_lorentzLie hG
  have hdet : (NormedSpace.exp G).det = 1 := spinLie_det_exp_eq_one hG
  refine ⟨?_, ?_, NormedSpace.exp (-A), hasLambda_exp hA⟩
  · rw [hdet]; exact isUnit_one
  · rw [hdet]; norm_num

/-- **Group-level Lemma 48 (Lorentz image).**  For `G ∈ 𝔰𝔭𝔦𝔫⁺(3,1)`, the
conjugation action of `exp G` on the Majorana basis is described by a Lorentz
matrix `Λ = exp(-A) ∈ O(1,3)`, where `A ∈ 𝔬(1,3)` is the adjoint matrix of `G`. -/
theorem spinLie_exp_hasLambda_lorentz (hG : IsSpinLie G) :
    ∃ Λ, HasLambda (NormedSpace.exp G) Λ ∧ Λ ∈ LorentzO := by
  obtain ⟨A, hA, hAL⟩ := spinLie_hasAdLambda_lorentzLie hG
  refine ⟨NormedSpace.exp (-A), hasLambda_exp hA, ?_⟩
  have hneg : -A ∈ LorentzLie := by
    have := lorentzLie_smul (-1 : ℝ) hAL
    simpa using this
  exact lorentzLie_exp hneg

end BookProof.ChapterA3
