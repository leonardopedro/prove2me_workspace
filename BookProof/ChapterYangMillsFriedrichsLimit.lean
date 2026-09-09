import Mathlib
import BookProof.ChapterYangMillsFriedrichs

/-!
# Quantum Yang–Mills, the Friedrichs route: the construction in the bounded regime
and the Hashimoto/SIRK limit

This module continues `BookProof.ChapterYangMillsFriedrichs`
(`PLAN_LEAN_SPECIALIST_QYM_FLOW.md`, Parts C and D) at the two places where that
module stopped:

* **Part C was conditional.**  There the Friedrichs theorem entered as a *named
  hypothesis*, shown consistent only in the degenerate case of an operator that
  is already defined on the whole space.  Here the hypothesis is **discharged,
  by an explicit construction, for a genuinely non-degenerate class**: a
  symmetric positive operator on a *proper* dense domain whose quadratic form is
  bounded.  `friedrichs_of_bounded` builds the extension (continuous extension
  by density) and proves all four clauses of
  `BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension`; the class is
  non-empty and non-trivial by `friedrichs_bounded_nontrivial_example`.

* **Part D.4 was recorded as a conjecture only.**  The obstruction named there
  was that the *limit operator of the Krylov flag* is not constructed.  In the
  bounded regime it can be: `sirk_compression_tendsto` proves that the
  Hashimoto/SIRK compressions `Pₙ A Pₙ` converge to `A` strongly whenever the
  Krylov flag of a seed is dense, and `sirk_limit_unique` proves that this limit
  determines the operator.  Combining these with Part C gives
  `sirk_limit_eq_positive_selfadjoint_extension`: *in the bounded regime the
  operator recovered in the infinite Hashimoto limit is the positive
  self-adjoint (Friedrichs) extension of the Weyl-gauge Hamiltonian.*  This is
  the conjecture of `CONSOLIDATED_PLAN.md` §11.2, proved under the standing
  boundedness hypothesis; the unbounded continuum case remains open and is not
  claimed.

## Scope

Nothing here claims self-adjointness of the *unbounded* continuum Yang–Mills
operator, nor a mass gap.  Everything below carries an explicit boundedness
hypothesis on the operator, which is exactly the hypothesis that makes the
Krylov limit an operator limit.
-/

namespace BookProof.YangMillsFriedrichsLimit

open BookProof.FarisLavine BookProof.YangMillsFriedrichs

/-! ## Part C — the Friedrichs hypothesis discharged for bounded operators -/

section Bounded

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- An everywhere-defined continuous operator, read as a linear map on the
submodule `⊤` — the shape in which
`BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension` expects an
extension. -/
noncomputable def topRestrict (A : F →L[ℂ] F) : (⊤ : Submodule ℂ F) →ₗ[ℂ] F :=
  A.toLinearMap.comp (⊤ : Submodule ℂ F).subtype

@[simp] theorem topRestrict_apply (A : F →L[ℂ] F) (x : (⊤ : Submodule ℂ F)) :
    topRestrict A x = A (x : F) := rfl

/-- Symmetry passes from a dense subspace to the whole space, for a *continuous*
operator. -/
theorem symmetricOn_top_of_dense {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : ∀ x y : D, (inner ℂ (A (x : F)) (y : F) : ℂ)
      = inner ℂ (x : F) (A (y : F))) :
    SymmetricOn (⊤ : Submodule ℂ F) (topRestrict A) := by
  -- first fix `x ∈ D` and let `y` run over the dense set
  have step1 : ∀ x : D, ∀ y : F, (inner ℂ (A (x : F)) y : ℂ) = inner ℂ (x : F) (A y) := by
    intro x
    have hcont₁ : Continuous fun y : F => (inner ℂ (A (x : F)) y : ℂ) :=
      Continuous.inner continuous_const continuous_id
    have hcont₂ : Continuous fun y : F => (inner ℂ (x : F) (A y) : ℂ) :=
      Continuous.inner continuous_const A.continuous
    have := Continuous.ext_on hdense hcont₁ hcont₂ (by
      rintro y hy
      exact hsym x ⟨y, hy⟩)
    exact fun y => congrFun this y
  -- now let `x` run over the dense set
  have step2 : ∀ y : F, ∀ x : F, (inner ℂ (A x) y : ℂ) = inner ℂ x (A y) := by
    intro y
    have hcont₁ : Continuous fun x : F => (inner ℂ (A x) y : ℂ) :=
      Continuous.inner A.continuous continuous_const
    have hcont₂ : Continuous fun x : F => (inner ℂ x (A y) : ℂ) :=
      Continuous.inner continuous_id continuous_const
    have := Continuous.ext_on hdense hcont₁ hcont₂ (by
      rintro x hx
      exact step1 ⟨x, hx⟩ y)
    exact fun x => congrFun this x
  intro x y
  exact step2 (y : F) (x : F)

/-- Positivity of the quadratic form passes from a dense subspace to the whole
space, for a *continuous* operator (nonnegativity is a closed condition). -/
theorem quadForm_top_nonneg_of_dense {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F))
    (hpos : ∀ x : D, 0 ≤ (inner ℂ (x : F) (A (x : F)) : ℂ).re) :
    ∀ y : (⊤ : Submodule ℂ F), 0 ≤ quadForm (topRestrict A) y := by
  have hcont : Continuous fun y : F => (inner ℂ y (A y) : ℂ).re :=
    Complex.continuous_re.comp (Continuous.inner continuous_id A.continuous)
  have hclosed : IsClosed {y : F | 0 ≤ (inner ℂ y (A y) : ℂ).re} :=
    isClosed_le continuous_const hcont
  have hsub : (D : Set F) ⊆ {y : F | 0 ≤ (inner ℂ y (A y) : ℂ).re} := by
    rintro y hy
    exact hpos ⟨y, hy⟩
  have huniv : ∀ y : F, 0 ≤ (inner ℂ y (A y) : ℂ).re := by
    intro y
    have := hclosed.closure_subset_iff.mpr hsub
    have hy : y ∈ closure (D : Set F) := by rw [hdense.closure_eq]; trivial
    exact this hy
  intro y
  exact huniv (y : F)

/-- **The Friedrichs hypothesis, discharged by construction in the bounded
regime.**  A densely defined symmetric positive operator whose norm is bounded
on its domain has an explicit positive self-adjoint extension: its continuous
extension to the whole space.  Unlike
`BookProof.YangMillsFriedrichs.friedrichs_hypothesis_satisfiable`, the domain
here may be a *proper* dense subspace. -/
theorem friedrichs_of_bounded [CompleteSpace F] {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (C : ℝ) (hbd : ∀ x : D, ‖H x‖ ≤ C * ‖(x : F)‖) :
    ∃ A : F →L[ℂ] F, (∀ x : D, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) := by
  -- the continuous extension
  have hb : ∀ x : D, ‖H x‖ ≤ C * ‖x‖ := fun x => by simpa using hbd x
  set Hc : D →L[ℂ] F := H.mkContinuous C hb with hHc
  have hdr : DenseRange (D.subtypeL) := by
    simpa [DenseRange, Submodule.subtypeL, Set.range_comp] using hdense
  have hui : IsUniformInducing (D.subtypeL) :=
    (isometry_subtype_coe (s := (D : Set F))).isUniformInducing
  set A : F →L[ℂ] F := Hc.extend D.subtypeL with hA
  have hagree : ∀ x : D, A (x : F) = H x := by
    intro x
    have := Hc.extend_eq hdr hui x
    simpa [hA, hHc] using this
  refine ⟨A, hagree, ?_, ?_, ?_, ?_⟩
  · intro x
    exact ⟨trivial, by simpa using hagree x⟩
  · refine symmetricOn_top_of_dense A hdense ?_
    intro x y
    rw [hagree x, hagree y]
    exact hsym x y
  · refine quadForm_top_nonneg_of_dense A hdense ?_
    intro x
    have := hpos x
    rwa [quadForm, ← hagree x] at this
  · -- the adjoint condition on the full space
    intro w u hw
    refine ⟨trivial, ?_⟩
    have hsymtop : SymmetricOn (⊤ : Submodule ℂ F) (topRestrict A) := by
      refine symmetricOn_top_of_dense A hdense ?_
      intro x y
      rw [hagree x, hagree y]
      exact hsym x y
    have hzero : ∀ v : (⊤ : Submodule ℂ F),
        (inner ℂ (v : F) (topRestrict A ⟨w, trivial⟩ - u) : ℂ) = 0 := by
      intro v
      rw [inner_sub_right, ← hw v, ← hsymtop v ⟨w, trivial⟩]
      ring
    have hd : (inner ℂ (topRestrict A ⟨w, trivial⟩ - u) (topRestrict A ⟨w, trivial⟩ - u) : ℂ) = 0 :=
      hzero ⟨topRestrict A ⟨w, trivial⟩ - u, trivial⟩
    exact sub_eq_zero.mp (inner_self_eq_zero.mp hd)

/-- The bounded class of `friedrichs_of_bounded` is **not vacuous and not
degenerate**: on any complete space the identity restricted to a proper dense
domain is symmetric, positive and bounded, so the construction applies with
`D ≠ ⊤` available whenever such a `D` exists. -/
theorem friedrichs_bounded_nontrivial_example [CompleteSpace F] (D : Submodule ℂ F)
    (hdense : Dense (D : Set F)) :
    ∃ A : F →L[ℂ] F, (∀ x : D, A (x : F) = D.subtype x) ∧
      IsPositiveSelfAdjointExtension (D.subtype) (topRestrict A) := by
  refine friedrichs_of_bounded (D.subtype) hdense (fun x y => rfl) (fun x => ?_) 1 (fun x => ?_)
  · simp only [quadForm, Submodule.subtype_apply]
    simpa using inner_self_nonneg (𝕜 := ℂ) (x := (x : F))
  · simp

end Bounded

/-! ### A genuinely proper dense domain

The class of `friedrichs_of_bounded` really does contain operators whose domain
is a *proper* dense subspace: in `ℓ²(ℕ, ℂ)` the span of the canonical orthonormal
basis is dense but omits every vector of infinite support. -/

section ProperDomain

open scoped InnerProductSpace ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- A vector all of whose orthonormal-basis coefficients are non-zero is **not**
in the algebraic span of the basis: the span consists of finitely supported
vectors. -/
theorem not_mem_span_of_repr_ne_zero (b : HilbertBasis ℕ ℂ F)
    (x : F) (hx : ∀ i, b.repr x i ≠ 0) : x ∉ Submodule.span ℂ (Set.range b) := by
  intro hmem
  obtain ⟨T, hTsub, hxT⟩ := Submodule.mem_span_finite_of_mem_span hmem
  have hinj : Function.Injective b := b.orthonormal.linearIndependent.injective
  have hfin : (b ⁻¹' (T : Set F)).Finite := (T.finite_toSet).preimage hinj.injOn
  obtain ⟨i, hi⟩ := hfin.infinite_compl.nonempty
  have hle : Submodule.span ℂ (T : Set F) ≤ LinearMap.ker (innerSL ℂ (b i)).toLinearMap := by
    refine Submodule.span_le.mpr ?_
    rintro y hy
    obtain ⟨j, rfl⟩ := hTsub hy
    have hji : j ≠ i := by
      rintro rfl
      exact hi hy
    simp only [SetLike.mem_coe, LinearMap.mem_ker, ContinuousLinearMap.coe_coe,
      innerSL_apply_apply]
    exact b.orthonormal.2 (Ne.symm hji)
  have h0 : (inner ℂ (b i) x : ℂ) = 0 := by simpa using hle hxT
  exact hx i (by rw [b.repr_apply_apply]; exact h0)

/-- The harmonic sequence is square-summable, so it is an element of
`ℓ²(ℕ, ℂ)` of infinite support. -/
theorem memℓp_one_div_succ : Memℓp (fun n : ℕ => (1 / (n + 1) : ℂ)) 2 := by
  rw [memℓp_gen_iff (by norm_num : (0 : ℝ) < (2 : ℝ≥0∞).toReal)]
  have hcong : ∀ n : ℕ, ‖(1 / (n + 1) : ℂ)‖ ^ (2 : ℝ≥0∞).toReal = (1 / ((n : ℝ) + 1)) ^ 2 := by
    intro n
    have hn : ‖(1 / (n + 1) : ℂ)‖ = 1 / ((n : ℝ) + 1) := by
      rw [norm_div]
      congr 1
      · simp
      · rw [show ((n : ℂ) + 1) = ((((n : ℝ) + 1) : ℝ) : ℂ) by push_cast; ring, Complex.norm_real,
          Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    rw [hn]
    norm_num
  rw [summable_congr hcong]
  have hs := Real.summable_one_div_nat_pow (p := 2) |>.mpr (by norm_num)
  refine ((summable_nat_add_iff 1).mpr hs).congr (fun n => ?_)
  push_cast
  rw [div_pow]
  norm_num

/-- **The bounded Friedrichs construction applies to a proper dense domain.**  In
`ℓ²(ℕ, ℂ)`, the span `D` of the canonical orthonormal basis is dense and `D ≠ ⊤`,
and the symmetric positive bounded operator `H = id|_D` on it has the explicit
positive self-adjoint extension supplied by `friedrichs_of_bounded`.  So the
Friedrichs hypothesis of `PLAN_LEAN_SPECIALIST_QYM_FLOW.md` Part C is discharged
on a class that is not the degenerate `D = ⊤` one. -/
theorem friedrichs_bounded_proper_domain_example :
    ∃ (D : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ)),
      Dense (D : Set (ℓ²(ℕ, ℂ))) ∧ D ≠ ⊤ ∧
      (∀ x : D, A (x : ℓ²(ℕ, ℂ)) = D.subtype x) ∧
      IsPositiveSelfAdjointExtension D.subtype (topRestrict A) := by
  set b : HilbertBasis ℕ ℂ (ℓ²(ℕ, ℂ)) := HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ _) with hb
  set D : Submodule ℂ (ℓ²(ℕ, ℂ)) := Submodule.span ℂ (Set.range b) with hD
  have hdense : Dense (D : Set (ℓ²(ℕ, ℂ))) :=
    Submodule.dense_iff_topologicalClosure_eq_top.mpr b.dense_span
  obtain ⟨A, hagree, hext⟩ := friedrichs_bounded_nontrivial_example D hdense
  refine ⟨D, A, hdense, ?_, hagree, hext⟩
  -- properness: the harmonic vector has all coefficients non-zero
  set x : ℓ²(ℕ, ℂ) := ⟨fun n : ℕ => (1 / (n + 1) : ℂ), memℓp_one_div_succ⟩ with hx
  have hcoeff : ∀ i, b.repr x i ≠ 0 := by
    intro i
    have hxi : (b.repr x : ℕ → ℂ) i = 1 / ((i : ℂ) + 1) := rfl
    rw [hxi]
    have hne : ((i : ℂ) + 1) ≠ 0 := by
      rw [show ((i : ℂ) + 1) = (((i + 1 : ℕ) : ℂ)) by push_cast; ring]
      exact_mod_cast Nat.succ_ne_zero i
    simpa using hne
  have hnot : x ∉ D := not_mem_span_of_repr_ne_zero b x hcoeff
  intro htop
  exact hnot (by rw [htop]; trivial)

end ProperDomain

/-! ## Part D — the Hashimoto/SIRK limit in the bounded regime -/

section Sirk

open BookProof.ChapterH5 BookProof.ChapterH9

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The **Hashimoto/SIRK order-`n` compression** of a bounded operator with
respect to the Krylov flag of a seed `v`: `Pₙ A Pₙ`, where `Pₙ` is the
orthogonal projection onto the order-`n` Krylov subspace. -/
noncomputable def sirkCompression (A : F →L[ℂ] F) (v : F) (n : ℕ) (u : F) : F :=
  (krylovSpan A.toLinearMap v n).starProjection
    (A ((krylovSpan A.toLinearMap v n).starProjection u))

/-- For a cyclic seed the Krylov projections converge strongly to the identity. -/
theorem krylov_starProjection_tendsto (A : F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F) : Set F)) (u : F) :
    Filter.Tendsto (fun n : ℕ => (krylovSpan A.toLinearMap v n).starProjection u)
      Filter.atTop (nhds u) := by
  have h := krylov_bestApprox_tendsto_zero A.toLinearMap v u hdense
  rw [tendsto_iff_norm_sub_tendsto_zero]
  simpa [norm_sub_rev] using h

/-- **The infinite Hashimoto/SIRK limit recovers the operator.**  For a bounded
operator with a cyclic seed, the order-`n` compressions `Pₙ A Pₙ` converge to
`A` in the strong operator topology.  This is the operator limit whose absence
was the obstruction to Part D.4 of `PLAN_LEAN_SPECIALIST_QYM_FLOW.md`. -/
theorem sirk_compression_tendsto (A : F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F) : Set F)) (u : F) :
    Filter.Tendsto (fun n : ℕ => sirkCompression A v n u) Filter.atTop (nhds (A u)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  -- `‖Pₙ A Pₙ u − A u‖ ≤ ‖A‖ ‖Pₙ u − u‖ + ‖Pₙ (A u) − A u‖`
  have hbound : ∀ n : ℕ, ‖sirkCompression A v n u - A u‖
      ≤ ‖A‖ * ‖(krylovSpan A.toLinearMap v n).starProjection u - u‖
        + ‖(krylovSpan A.toLinearMap v n).starProjection (A u) - A u‖ := by
    intro n
    have hsplit : sirkCompression A v n u - A u
        = (krylovSpan A.toLinearMap v n).starProjection
            (A ((krylovSpan A.toLinearMap v n).starProjection u) - A u)
          + ((krylovSpan A.toLinearMap v n).starProjection (A u) - A u) := by
      simp only [sirkCompression, map_sub]
      abel
    rw [hsplit]
    refine le_trans (norm_add_le _ _) ?_
    gcongr
    refine le_trans ((krylovSpan A.toLinearMap v n).norm_starProjection_apply_le _) ?_
    have hAsub : A ((krylovSpan A.toLinearMap v n).starProjection u) - A u
        = A ((krylovSpan A.toLinearMap v n).starProjection u - u) := by rw [map_sub]
    rw [hAsub]
    exact A.le_opNorm _
  have h1 : Filter.Tendsto
      (fun n : ℕ => ‖A‖ * ‖(krylovSpan A.toLinearMap v n).starProjection u - u‖)
      Filter.atTop (nhds 0) := by
    have := krylov_starProjection_tendsto A v hdense u
    rw [tendsto_iff_norm_sub_tendsto_zero] at this
    simpa using this.const_mul ‖A‖
  have h2 : Filter.Tendsto
      (fun n : ℕ => ‖(krylovSpan A.toLinearMap v n).starProjection (A u) - A u‖)
      Filter.atTop (nhds 0) := by
    have := krylov_starProjection_tendsto A v hdense (A u)
    rw [tendsto_iff_norm_sub_tendsto_zero] at this
    simpa using this
  have hsum : Filter.Tendsto
      (fun n : ℕ => ‖A‖ * ‖(krylovSpan A.toLinearMap v n).starProjection u - u‖
        + ‖(krylovSpan A.toLinearMap v n).starProjection (A u) - A u‖)
      Filter.atTop (nhds 0) := by simpa using h1.add h2
  refine squeeze_zero (fun n => norm_nonneg _) hbound hsum

/-- **The Hashimoto limit determines the operator.**  Two bounded operators that
agree on a dense Krylov flag are equal — so the limit of the SIRK compressions
selects a *unique* operator. -/
theorem sirk_limit_unique (A B : F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F) : Set F))
    (hagree : ∀ x ∈ (⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F), A x = B x) :
    A = B := by
  ext u
  have := Continuous.ext_on hdense A.continuous B.continuous (fun x hx => hagree x hx)
  exact congrFun this u

/-- **Part D.4 in the bounded regime.**  Let `H` be a densely defined symmetric
positive operator with bounded quadratic form (Part C), let `A` be the positive
self-adjoint extension constructed in `friedrichs_of_bounded`, and let `v` be a
cyclic seed for `A`.  Then the infinite Hashimoto/SIRK limit of the compressions
`Pₙ A Pₙ` exists strongly and equals that extension, and no other bounded
operator agrees with it on the Krylov flag.  This is the conjecture of
`CONSOLIDATED_PLAN.md` §11.2, proved under the boundedness hypothesis; the
unbounded continuum case is not claimed. -/
theorem sirk_limit_eq_positive_selfadjoint_extension [CompleteSpace F] {D : Submodule ℂ F}
    (H : D →ₗ[ℂ] F) (hdenseD : Dense (D : Set F)) (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (C : ℝ) (hbd : ∀ x : D, ‖H x‖ ≤ C * ‖(x : F)‖) (v : F) :
    ∃ A : F →L[ℂ] F,
      (∀ x : D, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) ∧
      (Dense ((⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F) : Set F) →
        (∀ u : F, Filter.Tendsto (fun n : ℕ => sirkCompression A v n u)
          Filter.atTop (nhds (A u)))
        ∧ ∀ B : F →L[ℂ] F,
            (∀ x ∈ (⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F), A x = B x) →
            A = B) := by
  obtain ⟨A, hagree, hext⟩ := friedrichs_of_bounded H hdenseD hsym hpos C hbd
  exact ⟨A, hagree, hext, fun hcyc =>
    ⟨fun u => sirk_compression_tendsto A v hcyc u, fun B hB => sirk_limit_unique A B v hcyc hB⟩⟩

end Sirk

/-! ## The Weyl-gauge Hamiltonian: the two parts combined -/

section Weyl

open BookProof.ChapterH5 BookProof.ChapterH9

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The Weyl-gauge Yang–Mills Hamiltonian in the bounded regime has an
explicit positive self-adjoint extension**, and the Hashimoto/SIRK compressions
of that extension converge to it strongly for any cyclic seed.  Everything in
`PLAN_LEAN_SPECIALIST_QYM_FLOW.md` Parts C and D is unconditional here except
the boundedness hypothesis `hbd`. -/
theorem weyl_friedrichs_bounded [CompleteSpace F] {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hdense : Dense (D : Set F))
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a)))
    (C : ℝ) (hbd : ∀ x : D, ‖weylOp pi Bf x‖ ≤ C * ‖(x : F)‖) (v : F) :
    ∃ A : F →L[ℂ] F,
      (∀ x : D, A (x : F) = weylOp pi Bf x) ∧
      IsPositiveSelfAdjointExtension (weylOp pi Bf) (topRestrict A) ∧
      (Dense ((⨆ k : ℕ, krylovSpan A.toLinearMap v k : Submodule ℂ F) : Set F) →
        ∀ u : F, Filter.Tendsto (fun k : ℕ => sirkCompression A v k u)
          Filter.atTop (nhds (A u))) := by
  obtain ⟨A, hagree, hext, hlim⟩ :=
    sirk_limit_eq_positive_selfadjoint_extension (weylOp pi Bf) hdense
      (weylOpDom_symmetricOn hpi hB) (weylOpDom_quadForm_nonneg hpi hB) C hbd v
  exact ⟨A, hagree, hext, fun hcyc => (hlim hcyc).1⟩

end Weyl

end BookProof.YangMillsFriedrichsLimit
