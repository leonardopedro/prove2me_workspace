import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA1
import BookProof.ChapterA1c
import BookProof.ChapterA1d
import BookProof.Complexification

/-!
# Chapter A, §A.1 — the real-system trichotomy (work-package N1 residue)

This file discharges the remaining N1 residue of `FORMALIZATION_ROADMAP.md`
(§A.1, **Prop 11**, the type assignment of an irreducible **real** system).

The complex side of Prop 11 is `realification_classification` in
`BookProof/ChapterA1g.lean`.  Here we treat the **real** side, classifying a real
system `(M, W)` by the structure of its endomorphism division algebra — the
standard **real / complex / quaternionic** trichotomy of Frobenius — phrased via
the **R-imaginary** operators of Def 8.2:

* **R-real type** — no R-imaginary operator commutes with `M` (endomorphism
  algebra `ℝ`);
* **R-complex type** — a commuting R-imaginary exists, but no *quaternionic*
  (anticommuting) pair does (endomorphism algebra `ℂ`);
* **R-pseudoreal type** — a quaternionic pair of commuting R-imaginaries exists
  (endomorphism algebra `ℍ`).

We prove the trichotomy is **exhaustive** (`rType_exhaustive`) and **mutually
exclusive**, and connect it to the Def-10 complexification framework: a commuting
R-imaginary makes the complexification `(M, Cx W)` **reducible**
(`cxSystem_reducible_of_commuting_rImaginary`).  Hence an **R-real** system —
one whose complexification is irreducible (`IsRReal`) — is of R-real type
(`IsRReal.not_hasCommutingRImaginary`).

The reducibility argument is the concrete eigenspace splitting behind Def 10:
the complexified R-imaginary `Jc := cxMap J` is `ℂ`-linear with `(Jc)² = -1`, so
its `+i` eigenspace `ker (Jc - i)` is a proper, non-trivial subsystem of
`(M, Cx W)` (its `-i` eigenspace being the complementary conjugate summand
`V ⊕ V̄`).

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

namespace BookProof.ChapterA

open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

/-! ## R-imaginary structures and the R-type predicates -/

/-- A real system **has a commuting R-imaginary** iff some R-imaginary operator
(Def 8.2: an isometry `J` with `J² = -1`) commutes with every `m ∈ M`. -/
def HasCommutingRImaginary (M : System ℝ W) : Prop :=
  ∃ J : W ≃ₗᵢ[ℝ] W, IsRImaginary M J

/-- A real system **has a quaternionic pair** iff it admits two commuting
R-imaginary operators `J, K` that **anticommute** (`J K = - K J`).  Together with
`J K` this realizes the quaternion units `i, j, k` in the endomorphism algebra. -/
def HasQuaternionicRImaginary (M : System ℝ W) : Prop :=
  ∃ J K : W ≃ₗᵢ[ℝ] W, IsRImaginary M J ∧ IsRImaginary M K ∧
    (∀ x, J (K x) = - K (J x))

/-- A quaternionic pair in particular gives a commuting R-imaginary. -/
lemma HasQuaternionicRImaginary.hasCommutingRImaginary {M : System ℝ W}
    (h : HasQuaternionicRImaginary M) : HasCommutingRImaginary M := by
  obtain ⟨J, _, hJ, _, _⟩ := h
  exact ⟨J, hJ⟩

/-- **R-real type.** A real system with no commuting R-imaginary operator
(endomorphism algebra `ℝ`). -/
def IsRRealType (M : System ℝ W) : Prop :=
  ¬ HasCommutingRImaginary M

/-- **R-complex type.** A commuting R-imaginary exists, but no quaternionic pair
(endomorphism algebra `ℂ`). -/
def IsRComplexType (M : System ℝ W) : Prop :=
  HasCommutingRImaginary M ∧ ¬ HasQuaternionicRImaginary M

/-- **R-pseudoreal type.** A quaternionic pair of commuting R-imaginaries exists
(endomorphism algebra `ℍ`). -/
def IsRPseudorealType (M : System ℝ W) : Prop :=
  HasQuaternionicRImaginary M

/-- **The R-type trichotomy is exhaustive.**  Every real system is of R-real,
R-complex or R-pseudoreal type. -/
lemma rType_exhaustive (M : System ℝ W) :
    IsRRealType M ∨ IsRComplexType M ∨ IsRPseudorealType M := by
  by_cases h1 : HasCommutingRImaginary M
  · by_cases h2 : HasQuaternionicRImaginary M
    · exact Or.inr (Or.inr h2)
    · exact Or.inr (Or.inl ⟨h1, h2⟩)
  · exact Or.inl h1

/-- R-real and R-complex types are mutually exclusive. -/
lemma not_isRRealType_and_isRComplexType (M : System ℝ W) :
    ¬ (IsRRealType M ∧ IsRComplexType M) := fun h => h.1 h.2.1

/-- R-real and R-pseudoreal types are mutually exclusive. -/
lemma not_isRRealType_and_isRPseudorealType (M : System ℝ W) :
    ¬ (IsRRealType M ∧ IsRPseudorealType M) :=
  fun h => h.1 h.2.hasCommutingRImaginary

/-- R-complex and R-pseudoreal types are mutually exclusive. -/
lemma not_isRComplexType_and_isRPseudorealType (M : System ℝ W) :
    ¬ (IsRComplexType M ∧ IsRPseudorealType M) := fun h => h.1.2 h.2

/-! ## The complexified R-imaginary and its eigenspace splitting -/

/-- The **complexification of an R-imaginary** operator, as a `ℂ`-linear bounded
operator on `Cx W`. -/
noncomputable def rImagCx (J : W ≃ₗᵢ[ℝ] W) : Cx W →L[ℂ] Cx W :=
  Cx.cxMap (J.toContinuousLinearEquiv.toContinuousLinearMap)

omit [CompleteSpace W] in
@[simp] lemma rImagCx_apply (J : W ≃ₗᵢ[ℝ] W) (x : Cx W) :
    rImagCx J x = ⟨J x.re, J x.im⟩ := rfl

/-- The complexified R-imaginary squares to `-1`. -/
lemma rImagCx_sq {M : System ℝ W} {J : W ≃ₗᵢ[ℝ] W} (hJ : IsRImaginary M J) (x : Cx W) :
    rImagCx J (rImagCx J x) = -x := by
  ext <;> simp [rImagCx_apply, hJ.1]

/-- The complexified R-imaginary commutes with every complexified operator of
the system (because `J` commutes with each `m`). -/
lemma rImagCx_commutes {M : System ℝ W} {J : W ≃ₗᵢ[ℝ] W} (hJ : IsRImaginary M J)
    {m : W →L[ℝ] W} (hm : m ∈ M.ops) (x : Cx W) :
    rImagCx J (Cx.cxMap m x) = Cx.cxMap m (rImagCx J x) := by
  ext <;> simp [rImagCx_apply, Cx.cxMap_apply, hJ.2 m hm]

/-- **A commuting R-imaginary makes the complexification reducible.**  For a real
system `(M, W)` on a non-trivial space that has a commuting R-imaginary operator,
the complexification `(M, Cx W)` is **not** irreducible: the `+i` eigenspace
`ker (Jc - i)` of the complexified R-imaginary is a proper, non-trivial
subsystem. -/
theorem cxSystem_reducible_of_commuting_rImaginary [Nontrivial W] (M : System ℝ W)
    (h : HasCommutingRImaginary M) : ¬ (cxSystem M).IsIrreducible := by
  intro h_irr
  obtain ⟨J, hJ⟩ := h
  obtain ⟨w, hw⟩ := exists_ne (0 : W)
  -- The `+i` eigenspace `W₀ = ker (Jc - i)` of the complexified R-imaginary.
  set T : Cx W →L[ℂ] Cx W := rImagCx J - Complex.I • (1 : Cx W →L[ℂ] Cx W) with hT
  set W₀ : Submodule ℂ (Cx W) := LinearMap.ker T.toLinearMap with hW₀
  -- `W₀` is a subsystem: closed (kernel of a continuous map) and invariant.
  have hW₀_subsystem : (cxSystem M).IsSubsystem W₀ := by
    refine ⟨T.isClosed_ker, ?_⟩
    rintro _ ⟨m, hm, rfl⟩ v hv
    simp only [hW₀, hT, LinearMap.mem_ker, ContinuousLinearMap.coe_coe,
      ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.one_apply, sub_eq_zero] at hv ⊢
    rw [rImagCx_commutes hJ hm, hv, map_smul]
  -- `W₀ ≠ ⊥`: it contains the nonzero vector `Jc (ofReal w) + i • ofReal w = ⟨J w, w⟩`.
  have hW₀_ne_bot : W₀ ≠ ⊥ := by
    set v : Cx W := rImagCx J (Cx.ofReal w) + Complex.I • Cx.ofReal w with hv
    have hv_mem : v ∈ W₀ := by
      simp only [hW₀, hT, LinearMap.mem_ker, ContinuousLinearMap.coe_coe,
        ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply,
        ContinuousLinearMap.one_apply, map_add, map_smul, hv, rImagCx_sq hJ]
      rw [smul_sub, smul_smul, Complex.I_mul_I]
      module
    have hv_ne : v ≠ 0 := by
      have him : v.im = w := by simp [hv, rImagCx_apply, Cx.ofReal, Cx.smul_I, map_zero]
      intro hzero
      rw [hzero] at him
      exact hw him.symm
    exact fun hbot => hv_ne (by simpa [hbot] using hv_mem)
  -- `W₀ ≠ ⊤`: else `ofReal w ∈ W₀`, forcing `⟨J w, 0⟩ = ⟨0, w⟩`, so `w = 0`.
  have hW₀_ne_top : W₀ ≠ ⊤ := by
    intro htop
    have hmem : Cx.ofReal w ∈ W₀ := htop ▸ Submodule.mem_top
    simp only [hW₀, hT, LinearMap.mem_ker, ContinuousLinearMap.coe_coe,
      ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.one_apply, sub_eq_zero, rImagCx_apply, Cx.ofReal,
      Cx.smul_I, map_zero] at hmem
    have := congr_arg Cx.im hmem
    simp at this
    exact hw this.symm
  exact (hW₀_subsystem |> h_irr W₀).elim hW₀_ne_bot hW₀_ne_top

/-- **An R-real system is of R-real type.**  If the complexification of a
real system on a non-trivial space is irreducible (`IsRReal`), then the system
has no commuting R-imaginary operator, i.e. it is of R-real type. -/
theorem IsRReal.not_hasCommutingRImaginary [Nontrivial W] {M : System ℝ W}
    (h : IsRReal M) : ¬ HasCommutingRImaginary M :=
  fun hJ => cxSystem_reducible_of_commuting_rImaginary M hJ h

/-- Restatement: an R-real system is of R-real type. -/
theorem IsRReal.isRRealType [Nontrivial W] {M : System ℝ W} (h : IsRReal M) :
    IsRRealType M :=
  h.not_hasCommutingRImaginary

/-- An R-complex-type system on a non-trivial space is **not** R-real: its
complexification is reducible. -/
theorem IsRComplexType.not_isRReal [Nontrivial W] {M : System ℝ W}
    (h : IsRComplexType M) : ¬ IsRReal M :=
  fun hRReal => hRReal.not_hasCommutingRImaginary h.1

/-- An R-pseudoreal-type system on a non-trivial space is **not** R-real: its
complexification is reducible. -/
theorem IsRPseudorealType.not_isRReal [Nontrivial W] {M : System ℝ W}
    (h : IsRPseudorealType M) : ¬ IsRReal M :=
  fun hRReal => hRReal.not_hasCommutingRImaginary h.hasCommutingRImaginary

/-- **R-real is the only type with an irreducible complexification.**  For a real
system on a non-trivial space, `IsRReal M` (irreducible complexification) forces
the R-real type and excludes the R-complex and R-pseudoreal types. -/
theorem IsRReal.excludes_other_types [Nontrivial W] {M : System ℝ W}
    (h : IsRReal M) : IsRRealType M ∧ ¬ IsRComplexType M ∧ ¬ IsRPseudorealType M := by
  refine ⟨h.isRRealType, ?_, ?_⟩
  · exact fun hc => hc.not_isRReal h
  · exact fun hc => hc.not_isRReal h

end BookProof.ChapterA
