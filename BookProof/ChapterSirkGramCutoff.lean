import Mathlib
import BookProof.ChapterSirkGramWhitening

/-!
# Chapter SirkGramCutoff — the numerical Gram cutoff controls the truncation defect

`CONSOLIDATED_PLAN.md` §12.2, the recorded residue of **Gap 4c**.

`BookProof/ChapterSirkGramWhitening.lean` quantifies the rank truncation of the
SIRK/Hashimoto solver through a *geometric* parameter `δ`: if every raw (rational)
Krylov vector `w i` sits within `δ` of the retained subspace, a reduced state
loses at most `δ √m ‖c‖`.  What was missing is the link between that `δ` and the
quantity the code actually thresholds — the **eigenvalues of the Gram matrix**
`G_{ij} = ⟪w i, w j⟫` that fall below the numerical cutoff (`rel_tol`) and are
discarded.

This module supplies that link.  With `u` an orthonormal eigenbasis of the Gram
operator (what the Hermitian eigendecomposition returns), eigenvalues `lam`, and
a retained index set `R` such that every *discarded* eigenvalue satisfies
`lam k ≤ tol`, the whole defect is `√tol`.

## Deliverables

* `IsGramEigen`, `exists_gramEigen` — the eigendecomposition of the Gram operator
  (it always exists: the operator is self-adjoint), `gramEigen_nonneg`,
  `inner_synthesis_gramEigen` (the synthesized eigenvectors are orthogonal with
  squared norms the eigenvalues) and `norm_sq_sum_orthogonal`.
* `norm_sub_proj_le_of_mem_range` — for an isometric embedding `V`, the point
  `V V∗ x` of `range V` is the closest one; the projection property the defect
  estimate needs.
* `dist_synthesis_retained_le` — **every state assembled from the raw vectors is
  within `√tol ‖c‖` of the retained subspace**.
* `defect_le_sqrt_cutoff` — hence each raw vector `w i` is within `√tol` of it:
  the geometric parameter of `ChapterSirkGramWhitening` obeys `δ ≤ √tol`.
* `sirk_end_to_end_truncated_cutoff` — the end-to-end SIRK bound with the
  additive truncation term `‖r(X)‖ √tol √m ‖c‖`, expressed purely through the
  numerical cutoff.
* `retainedVec`, `retainedEmbedding` — the embedding the code builds from the
  retained eigenpairs, `V = W U_R Λ_R^{−1/2}` (the inverse-square-root
  whitening), with `retainedVec_orthonormal`, `retainedEmbedding_isometry`
  (`V∗V = 1`) and `range_retainedEmbedding` (its range is the retained
  subspace), so that `defect_le_sqrt_cutoff_retained` applies to the object the
  solver actually produces.

Everything is `sorry`-free and `axiom`-free.

**Boundary.** `tol` is here an exact bound on the discarded Gram eigenvalues; the
floating-point analysis relating the *computed* eigenvalues to the exact ones
(plan §12.2 Gap 6) is not addressed and stays out of scope.
-/

noncomputable section

namespace BookProof.ChapterSirkGramCutoff

open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## 1. Pythagoras for an orthogonal family -/

omit [CompleteSpace E] in
/-- The squared norm of a combination of a pairwise orthogonal family whose
squared norms are `lam`: `‖∑ a k y k‖² = ∑ |a k|² lam k`. -/
theorem norm_sq_sum_orthogonal {m : ℕ} (y : Fin m → E) (lam : Fin m → ℝ)
    (h : ∀ k l, ⟪y k, y l⟫_ℂ = if k = l then (lam l : ℂ) else 0)
    (s : Finset (Fin m)) (a : Fin m → ℂ) :
    ‖∑ k ∈ s, a k • y k‖ ^ 2 = ∑ k ∈ s, ‖a k‖ ^ 2 * lam k := by
  have hinner : ⟪∑ k ∈ s, a k • y k, ∑ k ∈ s, a k • y k⟫_ℂ
      = ((∑ k ∈ s, ‖a k‖ ^ 2 * lam k : ℝ) : ℂ) := by
    rw [sum_inner]
    push_cast
    refine Finset.sum_congr rfl fun k hk => ?_
    rw [inner_sum, Finset.sum_eq_single k]
    · rw [inner_smul_left, inner_smul_right, h k k, if_pos rfl, ← mul_assoc,
        RCLike.conj_mul]
      norm_num
    · intro l _ hlk
      rw [inner_smul_left, inner_smul_right, h k l, if_neg (Ne.symm hlk)]
      ring
    · intro hk'
      exact absurd hk hk'
  have h2 := inner_self_eq_norm_sq_to_K (𝕜 := ℂ) (x := ∑ k ∈ s, a k • y k)
  rw [hinner] at h2
  have h3 : ((∑ k ∈ s, ‖a k‖ ^ 2 * lam k : ℝ) : ℂ)
      = ((‖∑ k ∈ s, a k • y k‖ ^ 2 : ℝ) : ℂ) := by push_cast at h2 ⊢; exact h2
  exact_mod_cast h3.symm

/-! ## 2. The eigendecomposition of the Gram operator -/

/-- `IsGramEigen w u lam` says that the orthonormal basis `u` diagonalizes the
Gram operator of the raw Krylov vectors `w` with eigenvalues `lam`: exactly the
output of the Hermitian eigendecomposition the solver performs. -/
def IsGramEigen {m : ℕ} (w : Fin m → E)
    (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ) : Prop :=
  ∀ k, gramOp w (u k) = (lam k : ℂ) • u k

/-- **The eigendecomposition exists**: the Gram operator is self-adjoint, hence
diagonalized by an orthonormal basis with real eigenvalues. -/
theorem exists_gramEigen {m : ℕ} (w : Fin m → E) :
    ∃ (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ),
      IsGramEigen w u lam := by
  have hsymm : ((gramOp w : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m)) :
      EuclideanSpace ℂ (Fin m) →ₗ[ℂ] EuclideanSpace ℂ (Fin m)).IsSymmetric := by
    intro x y
    have hsa := gramOp_isSelfAdjoint w
    rw [IsSelfAdjoint, ContinuousLinearMap.star_eq_adjoint] at hsa
    change ⟪gramOp w x, y⟫_ℂ = ⟪x, gramOp w y⟫_ℂ
    conv_lhs => rw [← hsa]
    rw [ContinuousLinearMap.adjoint_inner_left]
  have hfr : Module.finrank ℂ (EuclideanSpace ℂ (Fin m)) = m := by simp
  exact ⟨hsymm.eigenvectorBasis hfr, fun k => hsymm.eigenvalues hfr k,
    fun k => hsymm.apply_eigenvectorBasis hfr k⟩

variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

/-- The synthesized eigenvectors are pairwise orthogonal, with squared norms the
eigenvalues. -/
theorem inner_synthesis_gramEigen (heig : IsGramEigen w u lam) (k l : Fin m) :
    ⟪synthesis w (u k), synthesis w (u l)⟫_ℂ = if k = l then (lam l : ℂ) else 0 := by
  have hortho : ⟪u k, u l⟫_ℂ = if k = l then (1 : ℂ) else 0 :=
    orthonormal_iff_ite.mp u.orthonormal k l
  rw [← inner_gramOp, heig l, inner_smul_right, hortho]
  by_cases h : k = l <;> simp [h]

/-- The Gram eigenvalues are the squared norms of the synthesized eigenvectors. -/
theorem norm_sq_synthesis_gramEigen (heig : IsGramEigen w u lam) (k : Fin m) :
    ‖synthesis w (u k)‖ ^ 2 = lam k := by
  have h := inner_synthesis_gramEigen heig k k
  rw [if_pos rfl, inner_self_eq_norm_sq_to_K] at h
  have h2 : ((‖synthesis w (u k)‖ ^ 2 : ℝ) : ℂ) = ((lam k : ℝ) : ℂ) := by
    push_cast
    exact h
  exact Complex.ofReal_inj.mp h2

/-- The Gram eigenvalues are nonnegative. -/
theorem gramEigen_nonneg (heig : IsGramEigen w u lam) (k : Fin m) : 0 ≤ lam k := by
  rw [← norm_sq_synthesis_gramEigen heig k]; positivity

/-! ## 3. The projection property of an isometric embedding -/

/-- **`V V∗ x` is the closest point of `range V` to `x`**, for an isometric
embedding `V` (`V∗V = 1`).  This is what turns "some point of the retained
subspace is close to `x`" into a bound on the defect `‖x − V V∗ x‖` that the
SIRK truncation estimates are stated with. -/
theorem norm_sub_proj_le_of_mem_range {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (V : F →L[ℂ] E)
    (hV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (x : E) {y : E} (hy : ∃ z, V z = y) :
    ‖x - V (adjoint V x)‖ ≤ ‖x - y‖ := by
  obtain ⟨z, rfl⟩ := hy
  set Q := V (adjoint V x) with hQ
  have hVadj : ∀ t : F, adjoint V (V t) = t := by
    intro t
    have h := congrArg (fun (A : F →L[ℂ] F) => A t) hV
    simpa using h
  have hperp : ∀ t : F, ⟪x - Q, V t⟫_ℂ = 0 := by
    intro t
    have h1 : ⟪V t, x - Q⟫_ℂ = ⟪t, adjoint V (x - Q)⟫_ℂ :=
      (ContinuousLinearMap.adjoint_inner_right V t (x - Q)).symm
    have h2 : adjoint V (x - Q) = 0 := by
      rw [map_sub, hQ, hVadj]; simp
    rw [← inner_conj_symm, h1, h2, inner_zero_right, map_zero]
  have hkey : ⟪x - Q, x - V z⟫_ℂ = ⟪x - Q, x - Q⟫_ℂ := by
    have hsp : x - V z = (x - Q) + V (adjoint V x - z) := by
      rw [map_sub, hQ]; abel
    rw [hsp, inner_add_right, hperp, add_zero]
  have h2 : ‖x - Q‖ ^ 2 = RCLike.re ⟪x - Q, x - V z⟫_ℂ := by
    rw [hkey, inner_self_eq_norm_sq]
  have h3 : RCLike.re ⟪x - Q, x - V z⟫_ℂ ≤ ‖x - Q‖ * ‖x - V z‖ :=
    le_trans (RCLike.re_le_norm _) (norm_inner_le_norm _ _)
  rcases eq_or_lt_of_le (norm_nonneg (x - Q)) with h0 | h0
  · rw [← h0]; positivity
  · have h4 := h2.trans_le h3
    nlinarith

/-! ## 4. The cutoff bounds the distance to the retained subspace -/

omit [CompleteSpace E] in
/-- The synthesis map expands along the Gram eigenbasis. -/
theorem synthesis_eq_sum_gramEigen (c : EuclideanSpace ℂ (Fin m)) :
    synthesis w c = ∑ k, ⟪u k, c⟫_ℂ • synthesis w (u k) := by
  conv_lhs => rw [← u.sum_repr' c]
  rw [map_sum]
  exact Finset.sum_congr rfl fun k _ => map_smul _ _ _

/-- **The numerical cutoff controls the distance to the retained subspace.**  If
every discarded Gram eigenvalue is at most `tol`, then every state assembled from
the raw Krylov vectors is within `√tol ‖c‖` of the span of the *retained*
synthesized eigenvectors. -/
theorem dist_synthesis_retained_le (heig : IsGramEigen w u lam) {tol : ℝ}
    (R : Finset (Fin m)) (hcut : ∀ k ∉ R, lam k ≤ tol) (c : EuclideanSpace ℂ (Fin m)) :
    ‖synthesis w c - ∑ k ∈ R, ⟪u k, c⟫_ℂ • synthesis w (u k)‖ ≤ Real.sqrt tol * ‖c‖ := by
  set a : Fin m → ℂ := fun k => ⟪u k, c⟫_ℂ with ha
  have hsplit : synthesis w c - ∑ k ∈ R, a k • synthesis w (u k)
      = ∑ k ∈ Rᶜ, a k • synthesis w (u k) := by
    rw [synthesis_eq_sum_gramEigen (u := u) c, ← Finset.sum_add_sum_compl R
      (fun k => a k • synthesis w (u k))]
    abel
  have hpar : ∑ k, ‖a k‖ ^ 2 = ‖c‖ ^ 2 := u.sum_sq_norm_inner_right c
  have hnn : ∀ k, 0 ≤ lam k := gramEigen_nonneg heig
  rcases Finset.eq_empty_or_nonempty Rᶜ with hRc | hRc
  · rw [hsplit, hRc]
    simp only [Finset.sum_empty, norm_zero]
    have h0 : 0 ≤ Real.sqrt tol := Real.sqrt_nonneg _
    positivity
  · obtain ⟨k0, hk0⟩ := hRc
    have htol : 0 ≤ tol :=
      le_trans (hnn k0) (hcut k0 (Finset.mem_compl.mp hk0))
    have hsq : ‖∑ k ∈ Rᶜ, a k • synthesis w (u k)‖ ^ 2 ≤ tol * ‖c‖ ^ 2 := by
      rw [norm_sq_sum_orthogonal (fun k => synthesis w (u k)) lam
        (inner_synthesis_gramEigen heig) Rᶜ a]
      calc ∑ k ∈ Rᶜ, ‖a k‖ ^ 2 * lam k
          ≤ ∑ k ∈ Rᶜ, ‖a k‖ ^ 2 * tol := by
            refine Finset.sum_le_sum fun k hk => ?_
            exact mul_le_mul_of_nonneg_left (hcut k (Finset.mem_compl.mp hk))
              (by positivity)
        _ = (∑ k ∈ Rᶜ, ‖a k‖ ^ 2) * tol := by rw [Finset.sum_mul]
        _ ≤ (∑ k, ‖a k‖ ^ 2) * tol := by
            refine mul_le_mul_of_nonneg_right ?_ htol
            exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _)
              (fun k _ _ => by positivity)
        _ = tol * ‖c‖ ^ 2 := by rw [hpar]; ring
    rw [hsplit]
    have hgoal : ‖∑ k ∈ Rᶜ, a k • synthesis w (u k)‖ ^ 2 ≤ (Real.sqrt tol * ‖c‖) ^ 2 := by
      rw [mul_pow, Real.sq_sqrt htol]
      exact hsq
    have h1 := Real.sqrt_le_sqrt hgoal
    rwa [Real.sqrt_sq (norm_nonneg _), Real.sqrt_sq (by positivity)] at h1

omit [CompleteSpace E] in
/-- The synthesis map sends the `i`-th coordinate vector to the `i`-th raw
vector. -/
theorem synthesis_single (i : Fin m) :
    synthesis w (EuclideanSpace.single i (1 : ℂ)) = w i := by
  rw [synthesis_apply]
  rw [Finset.sum_eq_single i]
  · simp
  · intro j _ hj; simp [EuclideanSpace.single_apply, hj]
  · intro hi; exact absurd (Finset.mem_univ i) hi

/-- **The truncation defect is at most the square root of the numerical cutoff.**
If `V` is an isometric embedding whose range contains the retained synthesized
eigenvectors, and every discarded Gram eigenvalue is at most `tol`, then every
raw Krylov vector is within `√tol` of `range V`: the geometric parameter `δ` of
`ChapterSirkGramWhitening` satisfies `δ ≤ √tol`. -/
theorem defect_le_sqrt_cutoff (heig : IsGramEigen w u lam) {tol : ℝ}
    (R : Finset (Fin m)) (hcut : ∀ k ∉ R, lam k ≤ tol)
    {d : ℕ} (V : EuclideanSpace ℂ (Fin d) →L[ℂ] E)
    (hV : (adjoint V).comp V = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin d)))
    (hmem : ∀ k ∈ R, ∃ z, V z = synthesis w (u k)) (i : Fin m) :
    ‖w i - V (adjoint V (w i))‖ ≤ Real.sqrt tol := by
  set c : EuclideanSpace ℂ (Fin m) := EuclideanSpace.single i (1 : ℂ) with hc
  have hnormc : ‖c‖ = 1 := by simp [hc]
  have hwi : synthesis w c = w i := synthesis_single i
  set y : E := ∑ k ∈ R, ⟪u k, c⟫_ℂ • synthesis w (u k) with hy
  have hyrange : ∃ z, V z = y := by
    have hmemS : ∀ k ∈ R, ⟪u k, c⟫_ℂ • synthesis w (u k) ∈
        LinearMap.range (V : EuclideanSpace ℂ (Fin d) →ₗ[ℂ] E) := by
      intro k hk
      obtain ⟨z, hz⟩ := hmem k hk
      exact Submodule.smul_mem _ _ ⟨z, hz⟩
    have : y ∈ LinearMap.range (V : EuclideanSpace ℂ (Fin d) →ₗ[ℂ] E) :=
      Submodule.sum_mem _ hmemS
    obtain ⟨z, hz⟩ := this
    exact ⟨z, hz⟩
  have hclose : ‖w i - y‖ ≤ Real.sqrt tol := by
    have h := dist_synthesis_retained_le heig R hcut c
    rw [hwi, hnormc, mul_one] at h
    exact h
  exact le_trans (norm_sub_proj_le_of_mem_range V hV (w i) hyrange) hclose

/-- **The end-to-end SIRK bound in terms of the numerical Gram cutoff.**  This is
`ChapterSirkGramWhitening.sirk_end_to_end_truncated_gram` with the geometric
parameter `δ` replaced by `√tol`, `tol` being the threshold below which the code
discards Gram eigenvalues. -/
theorem sirk_end_to_end_truncated_cutoff (heig : IsGramEigen w u lam) {tol : ℝ}
    (R : Finset (Fin m)) (hcut : ∀ k ∉ R, lam k ≤ tol)
    {d : ℕ} (V : EuclideanSpace ℂ (Fin d) →L[ℂ] E)
    (rX : E →L[ℂ] E) (rB : EuclideanSpace ℂ (Fin d) →L[ℂ] EuclideanSpace ℂ (Fin d))
    (flow psiX : E →L[ℂ] E) (psiB : EuclideanSpace ℂ (Fin d) →L[ℂ] EuclideanSpace ℂ (Fin d))
    (C Dmin hrate : ℝ) (k : ℕ)
    (hV : (adjoint V).comp V = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin d)))
    (hmem : ∀ j ∈ R, ∃ z, V z = synthesis w (u j))
    (hViso : ∀ x : EuclideanSpace ℂ (Fin d), ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖adjoint V v‖ ≤ ‖v‖)
    (hflow : flow = psiX)
    (hcx1 : ‖psiX - rX‖ ≤ C * (Real.exp (-(hrate * k)) * Dmin))
    (hcx2 : ‖psiB - rB‖ ≤ C * (Real.exp (-(hrate * k)) * Dmin))
    (c : EuclideanSpace ℂ (Fin m))
    (hexact : rX (V (adjoint V (synthesis w c)))
      = V (rB (adjoint V (V (adjoint V (synthesis w c))))))
    (hproj : adjoint V (V (adjoint V (synthesis w c))) = adjoint V (synthesis w c)) :
    ‖flow (synthesis w c)
        - BookProof.ChapterSirkEndToEnd.sirkApprox V psiB (synthesis w c)‖
      ≤ BookProof.ChapterH6.sirkBound C Dmin hrate ‖synthesis w c‖ k
        + ‖rX‖ * (Real.sqrt tol * (Real.sqrt m * ‖c‖)) :=
  sirk_end_to_end_truncated_gram w V rX rB flow psiX psiB C Dmin hrate k hViso hVadj
    hflow hcx1 hcx2 (defect_le_sqrt_cutoff heig R hcut V hV hmem) c hexact hproj

/-! ## 5. The embedding the code builds: `V = W U_R Λ_R^{−1/2}` -/

/-- The **retained, whitened Krylov vectors** `λ_k^{−1/2} W u_k` for the retained
eigenpairs listed by `e`: the columns of the inverse-square-root whitening the
solver forms from the Hermitian eigendecomposition of the Gram matrix. -/
def retainedVec {d : ℕ} (w : Fin m → E)
    (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ)
    (e : Fin d → Fin m) : Fin d → E :=
  fun j => ((Real.sqrt (lam (e j)))⁻¹ : ℂ) • synthesis w (u (e j))

/-- The retained whitened vectors are orthonormal. -/
theorem retainedVec_orthonormal (heig : IsGramEigen w u lam) {d : ℕ} {e : Fin d → Fin m}
    (he : Function.Injective e) (hpos : ∀ j, 0 < lam (e j)) :
    Orthonormal ℂ (retainedVec w u lam e) := by
  rw [orthonormal_iff_ite]
  intro j l
  have hjl : ⟪synthesis w (u (e j)), synthesis w (u (e l))⟫_ℂ
      = if j = l then (lam (e l) : ℂ) else 0 := by
    rw [inner_synthesis_gramEigen heig]
    by_cases h : j = l
    · simp [h]
    · simp only [h, if_false]
      exact if_neg fun hh => h (he hh)
  have hexp : ⟪retainedVec w u lam e j, retainedVec w u lam e l⟫_ℂ
      = (starRingEnd ℂ) ((Real.sqrt (lam (e j)) : ℂ)⁻¹) *
          (((Real.sqrt (lam (e l)) : ℂ))⁻¹ *
            ⟪synthesis w (u (e j)), synthesis w (u (e l))⟫_ℂ) := by
    simp only [retainedVec, inner_smul_left, inner_smul_right]
    ring
  rw [hexp, hjl]
  by_cases h : j = l
  · subst h
    have hp := hpos j
    have hsne : ((Real.sqrt (lam (e j)) : ℝ) : ℂ) ≠ 0 := by
      simp only [ne_eq, Complex.ofReal_eq_zero]
      positivity
    have hsq : ((Real.sqrt (lam (e j)) : ℝ) : ℂ) * ((Real.sqrt (lam (e j)) : ℝ) : ℂ)
        = (lam (e j) : ℂ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt hp.le]
    have hconj : (starRingEnd ℂ) (((Real.sqrt (lam (e j)) : ℝ) : ℂ)⁻¹)
        = (((Real.sqrt (lam (e j)) : ℝ) : ℂ))⁻¹ := by
      rw [map_inv₀, Complex.conj_ofReal]
    rw [if_pos rfl, if_pos rfl, hconj, ← hsq]
    field_simp
  · simp [h]

/-- The **retained embedding** `V = W U_R Λ_R^{−1/2}` the code builds. -/
def retainedEmbedding {d : ℕ} (w : Fin m → E)
    (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ)
    (e : Fin d → Fin m) : EuclideanSpace ℂ (Fin d) →L[ℂ] E :=
  synthesis (retainedVec w u lam e)

/-- The synthesis map of an orthonormal family is an isometric embedding. -/
theorem synthesis_isometry_of_orthonormal {d : ℕ} {v : Fin d → E} (hv : Orthonormal ℂ v) :
    (adjoint (synthesis v)).comp (synthesis v)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin d)) := by
  refine adjoint_comp_self_of_inner _ fun a b => ?_
  have hortho : ∀ i j, ⟪v i, v j⟫_ℂ = if i = j then (1 : ℂ) else 0 :=
    orthonormal_iff_ite.mp hv
  rw [synthesis_apply, synthesis_apply, sum_inner]
  have hstep : ∀ i : Fin d, ⟪a i • v i, ∑ j, b j • v j⟫_ℂ
      = (starRingEnd ℂ) (a i) * b i := by
    intro i
    rw [inner_sum, Finset.sum_eq_single i]
    · rw [inner_smul_left, inner_smul_right, hortho i i, if_pos rfl, mul_one]
    · intro j _ hj
      rw [inner_smul_left, inner_smul_right, hortho i j, if_neg (Ne.symm hj)]
      ring
    · intro hi; exact absurd (Finset.mem_univ i) hi
  rw [Finset.sum_congr rfl fun i _ => hstep i]
  simp [PiLp.inner_apply, RCLike.inner_apply, mul_comm]

/-- The retained embedding is an isometric embedding: `V∗V = 1`. -/
theorem retainedEmbedding_isometry (heig : IsGramEigen w u lam) {d : ℕ} {e : Fin d → Fin m}
    (he : Function.Injective e) (hpos : ∀ j, 0 < lam (e j)) :
    (adjoint (retainedEmbedding w u lam e)).comp (retainedEmbedding w u lam e)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin d)) :=
  synthesis_isometry_of_orthonormal (retainedVec_orthonormal heig he hpos)

omit [CompleteSpace E] in
/-- The range of the retained embedding is the span of the retained synthesized
eigenvectors. -/
theorem range_retainedEmbedding {d : ℕ} (w : Fin m → E)
    (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ)
    (e : Fin d → Fin m) :
    LinearMap.range (retainedEmbedding w u lam e :
        EuclideanSpace ℂ (Fin d) →ₗ[ℂ] E)
      = Submodule.span ℂ (Set.range (retainedVec w u lam e)) :=
  range_synthesis _

omit [CompleteSpace E] in
/-- The retained synthesized eigenvectors lie in the range of the retained
embedding. -/
theorem mem_range_retainedEmbedding {d : ℕ} {e : Fin d → Fin m}
    (hpos : ∀ j : Fin d, 0 < lam (e j)) (j : Fin d) :
    ∃ z, retainedEmbedding w u lam e z = synthesis w (u (e j)) := by
  refine ⟨EuclideanSpace.single j ((Real.sqrt (lam (e j)) : ℂ)), ?_⟩
  have hs : Real.sqrt (lam (e j)) ≠ 0 := by
    have := hpos j; positivity
  have h1 : retainedEmbedding w u lam e (EuclideanSpace.single j
      ((Real.sqrt (lam (e j)) : ℂ))) = (Real.sqrt (lam (e j)) : ℂ) • retainedVec w u lam e j := by
    rw [retainedEmbedding, synthesis_apply, Finset.sum_eq_single j]
    · simp
    · intro l _ hl; simp [EuclideanSpace.single_apply, hl]
    · intro hj; exact absurd (Finset.mem_univ j) hj
  have hsne : ((Real.sqrt (lam (e j)) : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact hs
  rw [h1, retainedVec, smul_smul]
  rw [mul_inv_cancel₀ hsne, one_smul]

/-- **The defect bound for the embedding the solver actually produces.**  With
`V = W U_R Λ_R^{−1/2}` built from the retained eigenpairs (all retained
eigenvalues positive, all discarded ones at most `tol`), every raw Krylov vector
lies within `√tol` of `range V`. -/
theorem defect_le_sqrt_cutoff_retained (heig : IsGramEigen w u lam) {tol : ℝ}
    {d : ℕ} {e : Fin d → Fin m} (he : Function.Injective e)
    (hpos : ∀ j : Fin d, 0 < lam (e j))
    (hcut : ∀ k ∉ (Finset.univ.image e), lam k ≤ tol) (i : Fin m) :
    ‖w i - retainedEmbedding w u lam e
        (adjoint (retainedEmbedding w u lam e) (w i))‖ ≤ Real.sqrt tol := by
  refine defect_le_sqrt_cutoff heig (Finset.univ.image e) hcut _
    (retainedEmbedding_isometry heig he hpos) ?_ i
  intro k hk
  obtain ⟨j, _, rfl⟩ := Finset.mem_image.mp hk
  exact mem_range_retainedEmbedding hpos j

end BookProof.ChapterSirkGramCutoff
