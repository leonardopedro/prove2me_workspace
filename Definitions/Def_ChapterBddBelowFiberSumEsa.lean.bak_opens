import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterFarisLavineCore
import Mathlib


/-!
# QG-2 Case A, composed: a direct sum of bounded-below one-dimensional wall Hamiltonians

`BookProof/ChapterBddBelowWallEsa.lean` proves the one-dimensional input of
`CONSOLIDATED_PLAN.md`'s QG-2 **Case A**: `−d²/dx² + V` is essentially self-adjoint on the
compactly supported smooth core of `L²(ℝ)` for *every* smooth real potential bounded below,
with no growth and no sign hypothesis.  This module performs the **composition** step: it
glues an arbitrary family of such fibres into one operator on the orthogonal direct sum

`ℓ²(i : ι, L²(ℝ))`,   `H = ⊕ᵢ (−d²/dxᵢ² + Vᵢ)`,

and transports the three properties the plan asks of the composed object — essential
self-adjointness, the unitary flow it generates, and the lower bound on its quadratic form.

The gluing instrument is `BookProof.DirectSumEsa.dsOp_essentiallySelfAdjointOn` (a deficiency
space of an orthogonal direct sum is the direct sum of the fibre deficiency spaces), so no
relative bound, no comparison operator and no commutator estimate is needed; the whole
analytic content sits in the one-dimensional fibre theorem.

## What is proved

* `fiberCore`, `fiberSumHam` — the glued core `⊕ᵃˡᵍ Cc^∞(ℝ)` and the glued operator
  `⊕ᵢ (−d²/dxᵢ² + Vᵢ)`, with `fiberSumHam_single` and `fiberSumHam_symmetricOn`;
* `fiberCore_dense` — the glued core is dense;
* **`fiberSumHam_essentiallySelfAdjoint_of_bddBelow`** — the composed operator is
  essentially self-adjoint as soon as *each* fibre potential is bounded below (each with its
  own constant); `fiberSumHam_essentiallySelfAdjoint_of_bddBelow'` is the `BddBelow` form and
  `fiberSumHam_essentiallySelfAdjoint_of_nonneg` the non-negative case;
* `fiberSumHam_stone_flow` — the composed operator therefore has a unique self-adjoint
  extension and generates the unitary group `e^{−itH}`;
* **`fiberSumHam_semibounded`** — with a *uniform* lower bound `Vᵢ ≥ −c` the quadratic form
  of the composed operator is bounded below by `−c` (the fibrewise Green identity of
  `BookProof.WallEsaSemibounded`, summed over the fibres), and `fiberSumHam_nonneg_form`
  for `Vᵢ ≥ 0`;
* `qgFiberSum_esa`, `qgFiberSum_nonneg_form` — the physical instance of QG-3.3's derived
  fibre list: `d` shear directions carrying harmonic walls `ωᵢ² xᵢ²` together with one
  scalaron direction carrying the Starobinsky wall `starobinskyV M α`.

## Honest boundary

The decomposition is an **orthogonal direct sum** of one-dimensional fibres, not a tensor
product: the space is `ℓ²(ι, L²(ℝ))`, and this module says nothing about `−Δ + V` on
`L²(ℝ^d)` (whose deficiency analysis would need multi-dimensional elliptic regularity, which
is not available here).  Uniform boundedness below is needed only for the *form* bound; for
essential self-adjointness the constants may vary from fibre to fibre.  Nothing here concerns
the wrong-sign conformal direction, which is Case B and where the conclusion is false
(`BookProof/ChapterConformalFiberDeficiency.lean`).
-/

namespace BookProof.BddBelowFiberSumEsa
/-! ## Cross-chapter definitions from `BookProof.DirectSumEsa` -/
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

open MeasureTheory

noncomputable section

variable {ι : Type*}

/-- The one-particle space of the composed model: the orthogonal direct sum of one copy of
`L²(ℝ)` per fibre. -/
abbrev fiberSpace (ι : Type*) := lp (fun _ : ι => Lp ℂ 2 (volume : Measure ℝ)) 2

/-- The glued core: the algebraic direct sum of the fibre cores of compactly supported
smooth functions. -/
def fiberCore (ι : Type*) : Submodule ℂ (fiberSpace ι) := dsCore (fun _ : ι => ccDomain ℝ)

/-- **The composed operator** `⊕ᵢ (−d²/dxᵢ² + Vᵢ)` on the glued core. -/
def fiberSumHam (V : ι → ℝ → ℝ) (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) :
    fiberCore ι →ₗ[ℂ] fiberSpace ι :=
  dsOp (fun i => wallHam (V i) (hV i))







/-! ## Essential self-adjointness of the composed operator -/









/-! ## The quadratic form of the composed operator -/







/-! ## The physical instance: shear walls plus the scalaron wall -/

/-- The fibre list of QG-3.3's derived reduction: `d` shear directions carrying the harmonic
walls `ωᵢ² xᵢ²`, and one scalaron direction carrying the Starobinsky wall. -/
def qgFiberV (M alpha : ℝ) {d : ℕ} (omega : Fin d → ℝ) : Option (Fin d) → ℝ → ℝ
  | none => fun phi => BookProof.Starobinsky.starobinskyV M alpha phi
  | some i => fun x => omega i ^ 2 * x ^ 2

def contDiff_qgFiberV (M alpha : ℝ) {d : ℕ} (omega : Fin d → ℝ) (i : Option (Fin d)) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (qgFiberV M alpha omega i) := by
  cases i with
  | none => exact BookProof.ScalaronEsa.contDiff_starobinskyV M alpha
  | some i => exact contDiff_const.mul (contDiff_id.pow 2)











end

end BookProof.BddBelowFiberSumEsa
