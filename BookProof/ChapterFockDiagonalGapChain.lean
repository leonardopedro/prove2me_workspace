import Mathlib
import BookProof.ChapterScalaronFockGapChain

/-!
# Chapter FockDiagonalGapChain — the gap chain for a diagonal one-particle energy

`CONSOLIDATED_PLAN.md`, next step 3 of the top work package, asks for the abstract gap chain
to be run for the free sectors of the enclosure doctrine, whose one-particle operator is
*diagonal in the mode basis*: the one-particle energy of the mode `k` is a number `ω_k`.
`ChapterScalaronFockGapChain` did the constant case `ω_k = m`; this chapter does the general
diagonal case, which covers a genuine dispersion relation such as `ω_k = √(p_k² + m²)`.

## Deliverables

* `modeBasis b` — the finite-mode core `finiteModeDomain b` viewed as a free module with
  basis the (orthonormal) family `b`, and `modeBasis_coe`;
* `diagOnePart b w` — the diagonal one-particle operator `e_k ↦ ω_k e_k`, and the coordinate
  formula `diagOnePart_inner` for its sesquilinear form;
* `diagOnePart_symmetricOn`, `diagOnePart_quadForm_ge` — symmetry, and the one-particle form
  gap `⟪x, D x⟫ ≥ m‖x‖²` whenever every mode energy satisfies `ω_k ≥ m`: for a diagonal
  operator the form gap is *proved*, not assumed;
* **`diag_fock_gap`, `diag_fock_mass_gap`** — the resulting unconditional nested-Fock gap and
  mass gap of `dΓ(D)`;
* **`diag_fock_gap_of_field_perturbation`**, **`diag_fock_cubic_quartic_bounded_below`** — the
  gap under the unbounded, number-changing coupling `Φ(f)` with `2‖f‖ < m`, and
  semiboundedness with the single-mode cubic couplings and their normal-ordered quartic
  partners added;
* `freeDispersion m p k = √(p_k² + m²)` with `freeDispersion_ge`, and the free massive
  sector instance **`freeField_fock_mass_gap`** on the Hermite basis of `L²(ℝ)`: for any
  assignment of momenta to modes, the relativistic one-particle energy gives the outer Fock
  space the mass gap `m`.

## Honest boundary

The gap here is an honest theorem *about the model*: once the sector's one-particle energy
is diagonal with all mode energies at least `m`, the nested-Fock gap `m` and its stability
under the listed perturbations follow with no certificate and no Ritz data.  That a physical
sector reduces to such a diagonal energy is the modelling input of the enclosure doctrine
and is not proved here.  Massless dispersion gives `m = 0`, i.e. positivity and no gap.  The
cubic/quartic statement is semiboundedness with a negative constant, on single-mode terms.
The gauge-fixed Yang–Mills chain stays conditional on its one-particle form gap, and no mass
gap of the physical Yang–Mills Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockDiagonalGapChain

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore BookProof.ScalaronFockGapChain
open Module

section General

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-! ## 0. Two small coercion helpers -/

theorem conj_mul_ofReal (z : ℂ) : (starRingEnd ℂ) z * z = ((‖z‖ ^ 2 : ℝ) : ℂ) := by
  simpa using RCLike.conj_mul z

theorem inner_self_ofReal (v : F) : (inner ℂ v v : ℂ) = ((‖v‖ ^ 2 : ℝ) : ℂ) := by
  simp [inner_self_eq_norm_sq_to_K]

/-! ## 1. The finite-mode core as a free module -/

/-- The finite-mode core `finiteModeDomain b = span ℂ (range b)` of an orthonormal basis,
with the basis `b` itself as an algebraic basis. -/
def modeBasis (b : HilbertBasis ℕ ℂ F) : Basis ℕ ℂ (finiteModeDomain b) :=
  Basis.span b.orthonormal.linearIndependent

@[simp] theorem modeBasis_coe (b : HilbertBasis ℕ ℂ F) (i : ℕ) :
    ((modeBasis b i : finiteModeDomain b) : F) = b i :=
  Basis.span_apply _ i

/-- A core vector is the linear combination of the basis with its coordinates. -/
theorem coe_eq_linearCombination (b : HilbertBasis ℕ ℂ F) (x : finiteModeDomain b) :
    (x : F) = Finsupp.linearCombination ℂ (⇑b) ((modeBasis b).repr x) := by
  calc (x : F)
      = ((Finsupp.linearCombination ℂ (⇑(modeBasis b)) ((modeBasis b).repr x) :
          finiteModeDomain b) : F) := by
        rw [(modeBasis b).linearCombination_repr x]
    _ = Finsupp.linearCombination ℂ (⇑b) ((modeBasis b).repr x) := by
        simp only [Finsupp.linearCombination_apply, Finsupp.sum,
          AddSubmonoidClass.coe_finset_sum, Submodule.coe_smul, modeBasis_coe]

/-! ## 2. The diagonal one-particle operator -/

/-- **The diagonal one-particle operator** `e_k ↦ ω_k e_k` on the finite-mode core: the
one-particle energy of a free sector with mode energies `ω`. -/
def diagOnePart (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) :
    finiteModeDomain b →ₗ[ℂ] finiteModeDomain b :=
  (modeBasis b).constr ℂ fun i => ((w i : ℝ) : ℂ) • modeBasis b i

@[simp] theorem diagOnePart_basis (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (i : ℕ) :
    diagOnePart b w (modeBasis b i) = ((w i : ℝ) : ℂ) • modeBasis b i :=
  (modeBasis b).constr_basis ℂ _ i

/-- The image of a core vector, in coordinates. -/
theorem diagOnePart_coe (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (x : finiteModeDomain b) :
    ((diagOnePart b w x : finiteModeDomain b) : F)
      = ∑ i ∈ ((modeBasis b).repr x).support,
          (((w i : ℝ) : ℂ) * ((modeBasis b).repr x i)) • b i := by
  rw [diagOnePart, Basis.constr_apply, Finsupp.sum, AddSubmonoidClass.coe_finset_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Submodule.coe_smul, Submodule.coe_smul, modeBasis_coe, smul_smul,
    mul_comm ((modeBasis b).repr x i) (((w i : ℝ) : ℂ))]

/-- **The sesquilinear form of the diagonal operator, in coordinates.** -/
theorem diagOnePart_inner (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (x y : finiteModeDomain b) :
    (inner ℂ (x : F) ((diagOnePart b w y : finiteModeDomain b) : F) : ℂ)
      = ∑ i ∈ ((modeBasis b).repr y).support,
          ((w i : ℝ) : ℂ) * (starRingEnd ℂ ((modeBasis b).repr x i)) *
            ((modeBasis b).repr y i) := by
  rw [diagOnePart_coe, inner_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [inner_smul_right, coe_eq_linearCombination b x, b.orthonormal.inner_left_finsupp]
  ring

/-- The squared norm of a core vector, in coordinates. -/
theorem norm_sq_eq_sum (b : HilbertBasis ℕ ℂ F) (x : finiteModeDomain b) :
    ‖(x : F)‖ ^ 2 = ∑ i ∈ ((modeBasis b).repr x).support, ‖(modeBasis b).repr x i‖ ^ 2 := by
  have h : ((‖(x : F)‖ ^ 2 : ℝ) : ℂ)
      = ((∑ i ∈ ((modeBasis b).repr x).support, ‖(modeBasis b).repr x i‖ ^ 2 : ℝ) : ℂ) := by
    have h1 : (inner ℂ (x : F) (x : F) : ℂ) = ((‖(x : F)‖ ^ 2 : ℝ) : ℂ) :=
      inner_self_ofReal (x : F)
    rw [← h1, coe_eq_linearCombination b x, b.orthonormal.inner_finsupp_eq_sum_left]
    simp only [Finsupp.sum]
    push_cast
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [conj_mul_ofReal]
    push_cast
    ring
  exact_mod_cast h

/-- **The diagonal one-particle operator is symmetric** on the core. -/
theorem diagOnePart_symmetricOn (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) :
    SymmetricOn (finiteModeDomain b)
      ((finiteModeDomain b).subtype.comp (diagOnePart b w)) := by
  classical
  intro x y
  have hDx : ((finiteModeDomain b).subtype.comp (diagOnePart b w)) x
      = ((diagOnePart b w x : finiteModeDomain b) : F) := rfl
  have hDy : ((finiteModeDomain b).subtype.comp (diagOnePart b w)) y
      = ((diagOnePart b w y : finiteModeDomain b) : F) := rfl
  have hswap : (inner ℂ ((diagOnePart b w x : finiteModeDomain b) : F) (y : F) : ℂ)
      = (starRingEnd ℂ)
          (inner ℂ (y : F) ((diagOnePart b w x : finiteModeDomain b) : F) : ℂ) :=
    (inner_conj_symm (𝕜 := ℂ) ((diagOnePart b w x : finiteModeDomain b) : F) (y : F)).symm
  rw [hDx, hDy, hswap, diagOnePart_inner b w y x, diagOnePart_inner b w x y, map_sum]
  set lx := (modeBasis b).repr x with hlx
  set ly := (modeBasis b).repr y with hly
  have key : ∀ i : ℕ,
      (starRingEnd ℂ) (((w i : ℝ) : ℂ) * (starRingEnd ℂ) (ly i) * lx i)
        = ((w i : ℝ) : ℂ) * (starRingEnd ℂ) (lx i) * ly i := by
    intro i
    simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
    ring
  calc ∑ i ∈ lx.support, (starRingEnd ℂ) (((w i : ℝ) : ℂ) * (starRingEnd ℂ) (ly i) * lx i)
      = ∑ i ∈ lx.support ∪ ly.support,
          (starRingEnd ℂ) (((w i : ℝ) : ℂ) * (starRingEnd ℂ) (ly i) * lx i) := by
        refine Finset.sum_subset
          (Finset.subset_union_left (s₁ := lx.support) (s₂ := ly.support)) ?_
        intro i _ hi
        simp [Finsupp.notMem_support_iff.mp hi]
    _ = ∑ i ∈ lx.support ∪ ly.support,
          ((w i : ℝ) : ℂ) * (starRingEnd ℂ) (lx i) * ly i :=
        Finset.sum_congr rfl fun i _ => key i
    _ = ∑ i ∈ ly.support, ((w i : ℝ) : ℂ) * (starRingEnd ℂ) (lx i) * ly i := by
        refine (Finset.sum_subset
          (Finset.subset_union_right (s₁ := lx.support) (s₂ := ly.support)) ?_).symm
        intro i _ hi
        simp [Finsupp.notMem_support_iff.mp hi]

/-- **The one-particle form gap of a diagonal energy**: if every mode energy is at least
`m`, then `⟪x, D x⟫ ≥ m‖x‖²` on the whole core.  For a diagonal operator the form gap is a
theorem, not a hypothesis. -/
theorem diagOnePart_quadForm_ge (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ}
    (hw : ∀ k, m ≤ w k) (x : finiteModeDomain b) :
    m * ‖(x : F)‖ ^ 2
      ≤ quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) x := by
  classical
  have hform : quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) x
      = ∑ i ∈ ((modeBasis b).repr x).support, w i * ‖(modeBasis b).repr x i‖ ^ 2 := by
    have h : (inner ℂ (x : F) ((diagOnePart b w x : finiteModeDomain b) : F) : ℂ)
        = ((∑ i ∈ ((modeBasis b).repr x).support,
            w i * ‖(modeBasis b).repr x i‖ ^ 2 : ℝ) : ℂ) := by
      rw [diagOnePart_inner b w x x]
      push_cast
      refine Finset.sum_congr rfl fun i _ => ?_
      rw [mul_assoc, conj_mul_ofReal]
      push_cast
      ring
    have hq : quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) x
        = (inner ℂ (x : F) ((diagOnePart b w x : finiteModeDomain b) : F) : ℂ).re := rfl
    rw [hq, h, Complex.ofReal_re]
  rw [hform, norm_sq_eq_sum b x, Finset.mul_sum]
  exact Finset.sum_le_sum fun i _ =>
    mul_le_mul_of_nonneg_right (hw i) (sq_nonneg _)

/-! ## 3. The chain -/

/-- **The unconditional Fock gap of a diagonal one-particle energy.** -/
theorem diag_fock_gap (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ} (hm : 0 ≤ m)
    (hw : ∀ k, m ≤ w k) :
    dGamma (opCol b (diagOnePart b w)) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re :=
  fock_gap_of_one_particle_form_gap b (diagOnePart b w) hm (diagOnePart_quadForm_ge b w hw)

/-- The matrix gap condition `h − m ≥ 0` for a diagonal one-particle energy. -/
theorem diag_isPosCol_shiftCol (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ}
    (hw : ∀ k, m ≤ w k) :
    IsPosCol (shiftCol (opCol b (diagOnePart b w)) m) := by
  have hpos : ∀ x : finiteModeDomain b,
      0 ≤ quadForm ((finiteModeDomain b).subtype.comp
        (diagOnePart b w - ((m : ℝ) : ℂ) • LinearMap.id)) x := by
    intro x
    have hval : quadForm ((finiteModeDomain b).subtype.comp
        (diagOnePart b w - ((m : ℝ) : ℂ) • LinearMap.id)) x
        = quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) x
          - m * ‖(x : F)‖ ^ 2 := by
      simp only [quadForm, LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply,
        LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_sub,
        Submodule.coe_smul, inner_sub_right, inner_smul_right, Complex.sub_re,
        Complex.re_ofReal_mul, inner_self_eq_norm_sq_to_K]
      norm_cast
    have := diagOnePart_quadForm_ge b w hw x
    rw [hval]
    linarith
  rw [shiftCol_opCol]
  exact isPosCol_opCol hpos

/-- **The unconditional Fock mass gap of a diagonal one-particle energy.** -/
theorem diag_fock_mass_gap (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ} (hm : 0 < m)
    (hw : ∀ k, m ≤ w k) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (opCol b (diagOnePart b w))) A) ∧
      dGamma (opCol b (diagOnePart b w)) vac = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re := by
  obtain ⟨hvac, hgap⟩ := diag_fock_gap b w hm.le hw
  refine ⟨?_, hvac, hgap, fun u h0 hu => ?_⟩
  · refine secondQuantization_friedrichs b (diagOnePart b w) (diagOnePart_symmetricOn b w)
      fun x => ?_
    have h := diagOnePart_quadForm_ge b w hw x
    have hx : (0 : ℝ) ≤ ‖(x : F)‖ ^ 2 := sq_nonneg _
    nlinarith
  · have hnorm : 0 < ‖toLp u‖ := by
      have : toLp u ≠ 0 := fun hc => hu (toLp_injective (by simpa using hc))
      exact norm_pos_iff.mpr this
    have hquad := hgap u h0
    have hpos : 0 < m * ‖toLp u‖ ^ 2 := by positivity
    linarith

/-- **The gap of a diagonal energy survives an unbounded linear field coupling.** -/
theorem diag_fock_gap_of_field_perturbation (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ}
    (hm : 0 < m) (hw : ∀ k, m ≤ w k) {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < m)
    {u : FockAlg} (h0 : u 0 = 0) :
    0 < m - 2 * l2norm f ∧
      (m - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re :=
  fock_gap_of_field_perturbation_pos hm (diag_isPosCol_shiftCol b w hw) hf h0

/-- **The cubic-plus-quartic interaction keeps the energy of a diagonal sector bounded
below.** -/
theorem diag_fock_cubic_quartic_bounded_below (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ}
    (hm : 0 < m) (hw : ∀ k, m ≤ w k) (S : Finset ℕ) (lam : ℝ) (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - m) ^ 2 / 2)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) :=
  dGamma_multiMode_cubic_quartic_bounded_below S hm (diag_isPosCol_shiftCol b w hw) u

end General

/-! ## 4. The free massive sector -/

/-- **The relativistic one-particle energy** `ω_k = √(p_k² + m²)` of a free sector of mass
`m` whose mode `k` carries momentum `p k`. -/
def freeDispersion (m : ℝ) (p : ℕ → ℝ) (k : ℕ) : ℝ := Real.sqrt ((p k) ^ 2 + m ^ 2)

/-- Every mode energy of a free massive sector is at least the mass. -/
theorem freeDispersion_ge {m : ℝ} (hm : 0 ≤ m) (p : ℕ → ℝ) (k : ℕ) :
    m ≤ freeDispersion m p k := by
  have h : m ^ 2 ≤ (p k) ^ 2 + m ^ 2 := by nlinarith [sq_nonneg (p k)]
  calc m = Real.sqrt (m ^ 2) := (Real.sqrt_sq hm).symm
    _ ≤ Real.sqrt ((p k) ^ 2 + m ^ 2) := Real.sqrt_le_sqrt h

/-- **The free massive sector has the unconditional nested-Fock mass gap `m`.**  For any
assignment of momenta to the modes of the Hermite basis of `L²(ℝ)`, the second quantization
of the relativistic one-particle energy `√(p² + m²)` annihilates the outer vacuum, has a
positive self-adjoint (Friedrichs) extension, and has energy at least `m‖u‖²` — strictly
positive — on every nonzero vacuum-orthogonal finite-particle state. -/
theorem freeField_fock_mass_gap {m : ℝ} (hm : 0 < m) (p : ℕ → ℝ) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension
          (dGammaOp (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p)))) A) ∧
      dGamma (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) vac = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma
              (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma
            (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) u)) : ℂ).re :=
  diag_fock_mass_gap hermiteBasis (freeDispersion m p) hm (freeDispersion_ge hm.le p)

/-! ## 5. Axiom audit -/

section Audit

#print axioms diagOnePart_inner
#print axioms diagOnePart_symmetricOn
#print axioms diagOnePart_quadForm_ge
#print axioms diag_fock_gap
#print axioms diag_fock_mass_gap
#print axioms diag_fock_gap_of_field_perturbation
#print axioms diag_fock_cubic_quartic_bounded_below
#print axioms freeField_fock_mass_gap

end Audit

end BookProof.FockDiagonalGapChain

end
