import Mathlib
import BookProof.ChapterNavierStokesFockContinuum
import BookProof.ChapterStoneBridge
import BookProof.ChapterFarisLavine

/-!
# Fibrewise essential self-adjointness glues: the orthogonal direct sum

Essential self-adjointness is a statement about **two deficiency spaces**, and a deficiency
space of an orthogonal direct sum is the direct sum of the fibre deficiency spaces.  So the
step that passes essential self-adjointness from the fibres of a decomposition to the whole
space — the discrete form of the direct-integral gluing — is available in complete
generality, for *any* family of fibre operators, with no relative bound, no comparison
operator and no commutator estimate.

This module proves that, and applies it to the continuum Navier–Stokes Fock space.

## What is proved

* `dsCore` — the algebraic direct sum `⊕ᵃˡᵍ Dᵢ` of a family of fibre cores, a submodule of
  the Hilbert direct sum `ℓ²(i, Gᵢ)`, and `dsOp` — the direct sum `⊕ᵢ Hᵢ` of a family of
  fibre operators on it;
* `dsOp_single`, `dsOp_symmetricOn` — the operator on a single-fibre state is the fibre
  operator, and symmetry is fibrewise;
* `dsOp_deficiencyTrivialAt` — **the gluing step**: testing the deficiency identity against
  single-fibre states shows every coordinate of a deficiency vector vanishes;
* `dsOp_essentiallySelfAdjointOn` — **the instrument**: if every fibre operator is
  essentially self-adjoint on its core, the direct sum is essentially self-adjoint on the
  algebraic direct sum of the cores;
* `dsOpD`, `dsOpD_hasZeroDeficiencyOn`, `dsOpD_isSymmetricDom` — the same for
  *domain-preserving* fibre operators, in the `HasZeroDeficiencyOn` formulation used by the
  Navier–Stokes chapters;
* `dsCore_dense` — the glued core is dense as soon as every fibre core is;
* `dsOpD_stone_flow` — the glued operator therefore selects a unique self-adjoint
  extension and generates a complete unitary group on the direct sum;
* `fockCore`, `fockH`, `fockH_hasZeroDeficiencyOn`, `fockH_stone_flow` — **the payoff**:
  on the *whole* continuum Fock space `⊕ₙ L²(ℝⁿ)` of the parcel picture, the
  second-quantized Hamiltonian `ĥ = ∫ w(ξ) a†(ξ) a(ξ) dξ` — multiplication by the total
  energy `∑ₖ w(ξₖ)` on the `n`-parcel sector — is symmetric, densely defined and has
  vanishing adjoint deficiency on the direct sum of the bounded-energy cores.
  `BookProof.ChapterNavierStokesFockContinuum` proved this one sector at a time; this is
  the statement on the Fock space itself, for an arbitrary measurable field `w`, with no
  boundedness assumption and with (in general) purely continuous spectrum.  Running the
  Stone bridge on it gives `fockH_stone_flow`, the complete unitary group `e^{−itĥ}` on
  the continuum Fock space.

## Honest boundary

The decomposition is an *orthogonal direct sum*: the fibres must be mutually orthogonal
subspaces and the operator must preserve each of them.  Nothing here glues fibres of a
genuine direct *integral* over a continuous parameter, and nothing here provides a
decomposition — only the passage from fibres to the whole once one is given.  As
elsewhere in this development, no claim is made about global regularity of the classical
Navier–Stokes equation.
-/

open scoped ENNReal

namespace BookProof.DirectSumEsa

open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

/-- **The algebraic direct sum of the fibre cores.** -/
def dsCore (D : ∀ i, Submodule ℂ (G i)) : Submodule ℂ (lp G 2) where
  carrier := {f | {i | (f : ∀ i, G i) i ≠ 0}.Finite ∧ ∀ i, (f : ∀ i, G i) i ∈ D i}
  add_mem' := by
    rintro f g ⟨hf, hfD⟩ ⟨hg, hgD⟩
    constructor
    · refine Set.Finite.subset (hf.union hg) (fun i hi => ?_)
      simp only [Set.mem_setOf_eq, lp.coeFn_add, Pi.add_apply] at hi
      by_contra hcon
      simp only [Set.mem_union, Set.mem_setOf_eq, not_or, not_not] at hcon
      exact hi (by rw [hcon.1, hcon.2, add_zero])
    · intro i
      simp only [lp.coeFn_add, Pi.add_apply]
      exact Submodule.add_mem _ (hfD i) (hgD i)
  zero_mem' := by
    constructor
    · refine Set.Finite.subset (Set.finite_empty) (fun i hi => ?_)
      simp only [Set.mem_setOf_eq, lp.coeFn_zero, Pi.zero_apply, ne_eq, not_true_eq_false] at hi
    · intro i
      simp only [lp.coeFn_zero, Pi.zero_apply]
      exact Submodule.zero_mem _
  smul_mem' := by
    rintro c f ⟨hf, hfD⟩
    constructor
    · refine Set.Finite.subset hf (fun i hi => ?_)
      simp only [Set.mem_setOf_eq, lp.coeFn_smul, Pi.smul_apply] at hi ⊢
      intro h0
      exact hi (by rw [h0, smul_zero])
    · intro i
      simp only [lp.coeFn_smul, Pi.smul_apply]
      exact Submodule.smul_mem _ _ (hfD i)

theorem mem_dsCore {D : ∀ i, Submodule ℂ (G i)} {f : lp G 2} :
    f ∈ dsCore D ↔ {i | (f : ∀ i, G i) i ≠ 0}.Finite ∧ ∀ i, (f : ∀ i, G i) i ∈ D i := Iff.rfl

omit [∀ i, InnerProductSpace ℂ (G i)] in
theorem memLp_of_finite_support {f : ∀ i, G i} (h : {i | f i ≠ 0}.Finite) : Memℓp f 2 := by
  classical
  refine memℓp_gen (summable_of_ne_finset_zero (s := h.toFinset) fun i hi => ?_)
  have hzero : f i = 0 := by
    by_contra hne
    exact hi (h.mem_toFinset.mpr hne)
  simp [hzero]

variable {D : ∀ i, Submodule ℂ (G i)}

/-- **The direct sum of a family of fibre operators**, on the algebraic direct sum of the
fibre cores. -/
def dsOp (H : ∀ i, D i →ₗ[ℂ] G i) : dsCore D →ₗ[ℂ] lp G 2 where
  toFun x := ⟨fun i => H i ⟨(x : lp G 2) i, x.2.2 i⟩, by
    refine memLp_of_finite_support (Set.Finite.subset x.2.1 (fun i hi => ?_))
    simp only [Set.mem_setOf_eq] at hi ⊢
    intro h0
    refine hi ?_
    have : (⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ : D i) = 0 := Subtype.ext h0
    rw [this, map_zero]⟩
  map_add' x y := by
    refine lp.ext (funext fun i => ?_)
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    exact map_add (H i) ⟨((x : lp G 2)) i, x.2.2 i⟩ ⟨((y : lp G 2)) i, y.2.2 i⟩
  map_smul' c x := by
    refine lp.ext (funext fun i => ?_)
    simp only [RingHom.id_apply, SetLike.val_smul, lp.coeFn_smul, Pi.smul_apply]
    exact map_smul (H i) c ⟨((x : lp G 2)) i, x.2.2 i⟩

@[simp] theorem dsOp_coe (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) (i : ι) :
    ((dsOp H x : lp G 2) : ∀ i, G i) i = H i ⟨(x : lp G 2) i, x.2.2 i⟩ := rfl

/-! ## The single-fibre states -/

theorem single_mem_dsCore [DecidableEq ι] (i : ι) (u : D i) :
    (lp.single 2 i ((u : G i)) : lp G 2) ∈ dsCore D := by
  classical
  constructor
  · refine Set.Finite.subset (Set.finite_singleton i) (fun j hj => ?_)
    simp only [Set.mem_setOf_eq, lp.single_apply] at hj
    by_contra hne
    exact hj (Pi.single_eq_of_ne (by simpa [eq_comm] using hne) _)
  · intro j
    rw [lp.single_apply]
    by_cases hj : j = i
    · subst hj
      simp only [Pi.single_eq_same]
      exact u.2
    · rw [Pi.single_eq_of_ne (by simpa [eq_comm] using hj)]
      exact Submodule.zero_mem _

/-- The direct sum operator on a single-fibre state is the fibre operator. -/
theorem dsOp_single [DecidableEq ι] (H : ∀ i, D i →ₗ[ℂ] G i) (i : ι) (u : D i) :
    (dsOp H ⟨lp.single 2 i ((u : G i)), single_mem_dsCore i u⟩ : lp G 2)
      = lp.single 2 i (H i u) := by
  classical
  refine lp.ext (funext fun j => ?_)
  rw [lp.single_apply]
  have hcoe : ((dsOp H ⟨lp.single 2 i ((u : G i)), single_mem_dsCore i u⟩ : lp G 2)
      : ∀ i, G i) j
      = H j ⟨(lp.single 2 i ((u : G i)) : lp G 2) j, (single_mem_dsCore i u).2 j⟩ := rfl
  rw [hcoe]
  by_cases hj : j = i
  · subst hj
    have hu : (⟨(lp.single 2 j ((u : G j)) : lp G 2) j, (single_mem_dsCore j u).2 j⟩ : D j)
        = u := Subtype.ext (by
          change (lp.single 2 j ((u : G j)) : lp G 2) j = (u : G j)
          rw [lp.single_apply, Pi.single_eq_same])
    rw [Pi.single_eq_same]
    exact congrArg (H j) hu
  · have hzero : (⟨(lp.single 2 i ((u : G i)) : lp G 2) j, (single_mem_dsCore i u).2 j⟩ : D j)
        = 0 := Subtype.ext (by
          change (lp.single 2 i ((u : G i)) : lp G 2) j = (0 : G j)
          rw [lp.single_apply, Pi.single_eq_of_ne hj])
    rw [Pi.single_eq_of_ne hj]
    exact (congrArg (H j) hzero).trans (map_zero (H j))

/-! ## Symmetry and the deficiency spaces -/

theorem dsOp_symmetricOn (H : ∀ i, D i →ₗ[ℂ] G i) (hsym : ∀ i, SymmetricOn (D i) (H i)) :
    SymmetricOn (dsCore D) (dsOp H) := by
  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun i => ?_
  exact hsym i ⟨(x : lp G 2) i, x.2.2 i⟩ ⟨(y : lp G 2) i, y.2.2 i⟩

/-- **Fibrewise triviality of a deficiency space glues.** -/
theorem dsOp_deficiencyTrivialAt (H : ∀ i, D i →ₗ[ℂ] G i) {z : ℂ}
    (h : ∀ i, DeficiencyTrivialAt (D i) (H i) z) :
    DeficiencyTrivialAt (dsCore D) (dsOp H) z := by
  classical
  intro w hw
  have hcoord : ∀ i, ((w : lp G 2) : ∀ i, G i) i = 0 := by
    intro i
    refine h i _ (fun u => ?_)
    have hv := hw ⟨lp.single 2 i ((u : G i)), single_mem_dsCore i u⟩
    rw [dsOp_single H i u] at hv
    rw [lp.inner_single_left, lp.inner_single_left] at hv
    exact hv
  refine lp.ext (funext fun i => ?_)
  rw [hcoord i]
  simp

/-- **Fibrewise essential self-adjointness glues.** -/
theorem dsOp_essentiallySelfAdjointOn (H : ∀ i, D i →ₗ[ℂ] G i)
    (h : ∀ i, EssentiallySelfAdjointOn (D i) (H i)) :
    EssentiallySelfAdjointOn (dsCore D) (dsOp H) :=
  ⟨dsOp_deficiencyTrivialAt H (fun i => (h i).1),
    dsOp_deficiencyTrivialAt H (fun i => (h i).2)⟩

/-! ## 3. The domain-preserving form -/

section DomainPreserving

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

open BookProof.NavierStokesFlow in
/-- The two formulations of a vanishing deficiency agree for a domain-preserving
operator. -/
theorem hasZeroDeficiencyOn_of_essentiallySelfAdjointOn {Dom : Submodule ℂ F}
    (A : Dom →ₗ[ℂ] Dom) (h : EssentiallySelfAdjointOn Dom (Dom.subtype.comp A)) :
    HasZeroDeficiencyOn Dom A := by
  constructor
  · intro w hw
    refine h.1 w (fun v => ?_)
    have hv := hw v
    rw [inner_smul_right] at hv
    exact hv
  · intro w hw
    refine h.2 w (fun v => ?_)
    have hv : (inner ℂ ((A v : F)) w : ℂ) = inner ℂ ((v : F)) (-(Complex.I • w)) := hw v
    rw [inner_neg_right, inner_smul_right] at hv
    have hval : ((Dom.subtype ∘ₗ A) v : F) = (A v : F) := rfl
    rw [hval, hv]
    ring

open BookProof.NavierStokesFlow in
/-- The converse packaging: a domain-preserving operator with vanishing deficiency is
essentially self-adjoint when read as an operator into the ambient space. -/
theorem essentiallySelfAdjointOn_of_hasZeroDeficiencyOn {Dom : Submodule ℂ F}
    (A : Dom →ₗ[ℂ] Dom) (h : HasZeroDeficiencyOn Dom A) :
    EssentiallySelfAdjointOn Dom (Dom.subtype.comp A) := by
  constructor
  · intro w hw
    refine h.1 w (fun v => ?_)
    have hv : (inner ℂ (((Dom.subtype.comp A) v : F)) w : ℂ)
        = Complex.I * inner ℂ ((v : F)) w := hw v
    rw [inner_smul_right]
    exact hv
  · intro w hw
    refine h.2 w (fun v => ?_)
    have hv : (inner ℂ (((Dom.subtype.comp A) v : F)) w : ℂ)
        = -Complex.I * inner ℂ ((v : F)) w := hw v
    rw [inner_neg_right, inner_smul_right]
    exact hv.trans (by ring)

end DomainPreserving

/-- **The direct sum of a family of domain-preserving fibre operators.** -/
def dsOpD (A : ∀ i, D i →ₗ[ℂ] D i) : dsCore D →ₗ[ℂ] dsCore D :=
  LinearMap.codRestrict (dsCore D) (dsOp (fun i => (D i).subtype.comp (A i)))
    (fun x => by
      constructor
      · refine Set.Finite.subset x.2.1 (fun i hi => ?_)
        simp only [Set.mem_setOf_eq] at hi ⊢
        intro h0
        refine hi ?_
        have hz : (⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ : D i) = 0 := Subtype.ext h0
        have hval : ((dsOp (fun i => (D i).subtype.comp (A i)) x : lp G 2) : ∀ i, G i) i
            = ((A i) ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ : G i) := rfl
        rw [hval, hz, map_zero]
        rfl
      · intro i
        exact (A i ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩).2)

theorem subtype_comp_dsOpD (A : ∀ i, D i →ₗ[ℂ] D i) :
    (dsCore D).subtype.comp (dsOpD A) = dsOp (fun i => (D i).subtype.comp (A i)) := rfl

theorem dsOpD_coe (A : ∀ i, D i →ₗ[ℂ] D i) (x : dsCore D) :
    ((dsOpD A x : dsCore D) : lp G 2)
      = (dsOp (fun i => (D i).subtype.comp (A i)) x : lp G 2) := rfl

open BookProof.NavierStokesFlow in
/-- **Fibrewise vanishing deficiency glues** (domain-preserving form). -/
theorem dsOpD_hasZeroDeficiencyOn (A : ∀ i, D i →ₗ[ℂ] D i)
    (h : ∀ i, HasZeroDeficiencyOn (D i) (A i)) :
    HasZeroDeficiencyOn (dsCore D) (dsOpD A) := by
  refine hasZeroDeficiencyOn_of_essentiallySelfAdjointOn _
    (dsOp_essentiallySelfAdjointOn (fun i => (D i).subtype.comp (A i)) (fun i => ⟨?_, ?_⟩))
  · intro w hw
    refine (h i).1 w (fun v => ?_)
    rw [inner_smul_right]
    exact hw v
  · intro w hw
    refine (h i).2 w (fun v => ?_)
    have hv : (inner ℂ ((A i v : G i)) w : ℂ) = -Complex.I * inner ℂ ((v : G i)) w := hw v
    rw [inner_neg_right, inner_smul_right, hv]
    ring

open BookProof.NavierStokesFlow.FullEsa in
/-- The direct sum of symmetric fibre operators is symmetric. -/
theorem dsOpD_isSymmetricDom (A : ∀ i, D i →ₗ[ℂ] D i)
    (hsym : ∀ i, IsSymmetricDom (A i)) : IsSymmetricDom (dsOpD A) :=
  fun x y => dsOp_symmetricOn (fun i => (D i).subtype.comp (A i)) (fun i u v => hsym i u v) x y

/-! ## 4. The glued core is dense -/

/-- If every fibre core is dense in its fibre, the algebraic direct sum of the fibre cores
is dense in the direct sum. -/
theorem dsCore_dense (hD : ∀ i, Dense ((D i : Submodule ℂ (G i)) : Set (G i))) :
    Dense ((dsCore D : Submodule ℂ (lp G 2)) : Set (lp G 2)) := by
  classical
  refine Metric.dense_iff.2 (fun f ε hε => ?_)
  have hsum : HasSum (fun i => lp.single 2 i ((f : ∀ i, G i) i)) f :=
    lp.hasSum_single (by simp) f
  have hev : ∀ᶠ s : Finset ι in Filter.atTop,
      (∑ i ∈ s, lp.single 2 i ((f : ∀ i, G i) i)) ∈ Metric.ball f (ε / 2) :=
    hsum (Metric.ball_mem_nhds f (by positivity))
  obtain ⟨s, hs⟩ := hev.exists
  have hδpos : 0 < ε / (2 * (s.card + 1)) := by positivity
  have hchoice : ∀ i : ι, ∃ d : G i, d ∈ D i ∧ ‖d - (f : ∀ i, G i) i‖ < ε / (2 * (s.card + 1)) := by
    intro i
    obtain ⟨d, hdball, hdmem⟩ := Metric.dense_iff.1 (hD i) ((f : ∀ i, G i) i) _ hδpos
    refine ⟨d, hdmem, ?_⟩
    rw [← dist_eq_norm]
    simpa [dist_comm] using hdball
  choose d hdmem hdclose using hchoice
  refine ⟨∑ i ∈ s, lp.single 2 i (d i), ?_, ?_⟩
  · have hgF : ‖(∑ i ∈ s, lp.single 2 i (d i))
        - ∑ i ∈ s, lp.single 2 i ((f : ∀ i, G i) i)‖ ≤ ∑ i ∈ s, ‖d i - (f : ∀ i, G i) i‖ := by
      rw [← Finset.sum_sub_distrib]
      refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun i _ => ?_)
      rw [← lp.single_sub]
      exact le_of_eq (lp.norm_single (by norm_num) i _)
    have hcard : ∑ i ∈ s, ‖d i - (f : ∀ i, G i) i‖ ≤ s.card * (ε / (2 * (s.card + 1))) := by
      refine le_trans (Finset.sum_le_card_nsmul s _ (ε / (2 * (s.card + 1)))
        (fun i _ => (hdclose i).le)) ?_
      simp [nsmul_eq_mul]
    have hlt : (s.card : ℝ) * (ε / (2 * (s.card + 1))) < ε / 2 := by
      have hc : (0 : ℝ) ≤ (s.card : ℝ) := Nat.cast_nonneg _
      have hpos : (0 : ℝ) < 2 * ((s.card : ℝ) + 1) := by positivity
      rw [mul_div_assoc', div_lt_div_iff₀ hpos (by norm_num : (0 : ℝ) < 2)]
      nlinarith [hε, hc]
    have hball : dist (∑ i ∈ s, lp.single 2 i ((f : ∀ i, G i) i)) f < ε / 2 := hs
    have : dist (∑ i ∈ s, lp.single 2 i (d i)) f < ε := by
      calc dist (∑ i ∈ s, lp.single 2 i (d i)) f
          ≤ dist (∑ i ∈ s, lp.single 2 i (d i))
              (∑ i ∈ s, lp.single 2 i ((f : ∀ i, G i) i))
            + dist (∑ i ∈ s, lp.single 2 i ((f : ∀ i, G i) i)) f := dist_triangle _ _ _
        _ < ε / 2 + ε / 2 := by
            rw [dist_eq_norm]
            exact add_lt_add_of_le_of_lt (lt_of_le_of_lt (le_trans hgF hcard) hlt).le hball
        _ = ε := by ring
    simpa [Metric.mem_ball] using this
  · exact Submodule.sum_mem _ (fun i _ => single_mem_dsCore i ⟨d i, hdmem i⟩)

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FullEsa in
/-- **The unitary flow of a glued direct-sum operator.**  If every fibre core is dense and
every fibre operator is symmetric with vanishing deficiency, the direct sum is essentially
self-adjoint on the glued core, so it selects a unique self-adjoint extension and Stone's
theorem produces the complete unitary group it generates. -/
theorem dsOpD_stone_flow [∀ i, CompleteSpace (G i)] (A : ∀ i, D i →ₗ[ℂ] D i)
    (hdense : ∀ i, Dense ((D i : Submodule ℂ (G i)) : Set (G i)))
    (hsym : ∀ i, IsSymmetricDom (A i)) (h : ∀ i, HasZeroDeficiencyOn (D i) (A i)) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint (lp G 2))
      (U : ℝ → (lp G 2 →L[ℂ] lp G 2)),
      EsaClosure.IsSelfAdjointExtension ((dsCore D).subtype.comp (dsOpD A)) T.op ∧
        StoneBridge.IsStoneFlow T U :=
  StoneBridge.exists_stone_flow_of_esa _ (dsCore_dense hdense)
    (dsOp_symmetricOn _ (fun i u v => hsym i u v))
    (essentiallySelfAdjointOn_of_hasZeroDeficiencyOn _ (dsOpD_hasZeroDeficiencyOn A h))

/-! ## 5. The payoff: the continuum Fock space of the parcel picture -/

section FockSpace

open MeasureTheory BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum

/-- The `n`-parcel sector `L²(ℝⁿ)` of the continuum Fock space. -/
abbrev parcelSector (n : ℕ) := Lp ℂ 2 (volume : Measure (Fin n → ℝ))

/-- **The continuum Fock space** `⊕ₙ L²(ℝⁿ)` of the parcel picture. -/
abbrev fockSpace := lp (fun n : ℕ => parcelSector n) 2

/-- The bounded-energy core of the `n`-parcel sector. -/
def sectorCore (w : ℝ → ℝ) (n : ℕ) : Submodule ℂ (parcelSector n) :=
  boundedEnergyCore (volume : Measure (Fin n → ℝ)) (sectorEnergy w n)

/-- **The core of the Fock Hamiltonian**: the algebraic direct sum of the bounded-energy
cores of the sectors. -/
def fockCore (w : ℝ → ℝ) : Submodule ℂ fockSpace := dsCore (sectorCore w)

/-- **The second-quantized Hamiltonian on the whole continuum Fock space**: on the
`n`-parcel sector it is multiplication by the total energy `∑ₖ w(ξₖ)`. -/
def fockH {w : ℝ → ℝ} (hw : Measurable w) : fockCore w →ₗ[ℂ] fockCore w :=
  dsOpD (fun n => multOp (volume : Measure (Fin n → ℝ)) (sectorEnergy_measurable hw n))

/-- The core is dense in the Fock space. -/
theorem fockCore_dense {w : ℝ → ℝ} (hw : Measurable w) :
    Dense ((fockCore w : Submodule ℂ fockSpace) : Set fockSpace) :=
  dsCore_dense (fun n => boundedEnergyCore_dense _ (sectorEnergy_measurable hw n))

/-- The Fock Hamiltonian is symmetric on the core. -/
theorem fockH_isSymmetricDom {w : ℝ → ℝ} (hw : Measurable w) :
    FullEsa.IsSymmetricDom (fockH hw) :=
  dsOpD_isSymmetricDom _ (fun n => multOp_isSymmetricDom _ (sectorEnergy_measurable hw n))

/-- **The second-quantized Hamiltonian of the continuum parcel picture has vanishing
adjoint deficiency on the whole Fock space.**  For an arbitrary measurable field `w` —
unbounded allowed, so the sector operators have in general purely continuous spectrum and
no eigenvectors — the operator `ĥ = ∫ w(ξ)a†(ξ)a(ξ)dξ` is essentially self-adjoint on the
direct sum of the bounded-energy cores of the parcel sectors. -/
theorem fockH_hasZeroDeficiencyOn {w : ℝ → ℝ} (hw : Measurable w) :
    HasZeroDeficiencyOn (fockCore w) (fockH hw) :=
  dsOpD_hasZeroDeficiencyOn _
    (fun n => multOp_hasZeroDeficiencyOn _ (sectorEnergy_measurable hw n))

/-- The Fock Hamiltonian, viewed as an operator into the ambient Fock space, is
essentially self-adjoint on the core. -/
theorem fockH_essentiallySelfAdjointOn {w : ℝ → ℝ} (hw : Measurable w) :
    EssentiallySelfAdjointOn (fockCore w) ((fockCore w).subtype.comp (fockH hw)) :=
  essentiallySelfAdjointOn_of_hasZeroDeficiencyOn _ (fockH_hasZeroDeficiencyOn hw)

/-- **The complete unitary flow of the continuum Fock Hamiltonian.**  Essential
self-adjointness on a dense core selects a unique self-adjoint extension, and Stone's
theorem turns it into the global unitary group `e^{−itĥ}` solving the Schrödinger equation
on the whole continuum Fock space. -/
theorem fockH_stone_flow {w : ℝ → ℝ} (hw : Measurable w) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint fockSpace)
      (U : ℝ → (fockSpace →L[ℂ] fockSpace)),
      EsaClosure.IsSelfAdjointExtension ((fockCore w).subtype.comp (fockH hw)) T.op ∧
        StoneBridge.IsStoneFlow T U :=
  dsOpD_stone_flow _
    (fun n => boundedEnergyCore_dense _ (sectorEnergy_measurable hw n))
    (fun n => multOp_isSymmetricDom _ (sectorEnergy_measurable hw n))
    (fun n => multOp_hasZeroDeficiencyOn _ (sectorEnergy_measurable hw n))

end FockSpace

end

end BookProof.DirectSumEsa
