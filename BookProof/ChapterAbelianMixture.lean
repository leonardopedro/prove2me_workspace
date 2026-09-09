import Mathlib
import BookProof.ChapterLinftyMultiplication

/-!
# The mixed (atomic ⊕ diffuse) class of the abelian von Neumann list (plan Part F.5)

The abelian von Neumann classification quoted in the book lists the finite
diagonal algebras `ℓ∞(n)` (`ChapterAbelianDiagonal`,
`ChapterAbelianVonNeumannFinite`), the countable diagonal algebra `ℓ∞(ℕ)` on
`ℓ²(ℕ)` (`ChapterAbelianDiagonalCountable`), the diffuse model `L∞(μ)` on
`L²(μ)` (`ChapterLinftyMultiplication`) — and the **mixtures** of an atomic and a
diffuse part.  This module supplies a mixture.

The witness is deliberately elementary: on `ℝ` take

  `mixtureMeasure := volume|_{[0,1]} + δ₂`,

a finite measure with a genuine atom (at `2`) *and* a diffuse part of positive
mass (`[0,1]`, every point of which is null).  Multiplication by essentially
bounded functions on `L²(mixtureMeasure)` is then a unital, abelian, star-closed
and faithful algebra of bounded operators whose underlying measure is neither
purely atomic nor atomless.

## Deliverables

* `mixtureMeasure`, `instIsFiniteMeasureMixture`, `mixtureMeasure_univ` — the
  mixture is a finite measure of total mass `2`;
* `mixtureMeasure_atom` — the atomic part: `μ{2} = 1 > 0`;
* `mixtureMeasure_diffuse_point` — the diffuse part: `μ{x} = 0` for every
  `x ∈ [0,1]`;
* `mixtureMeasure_diffuse_mass` — that diffuse part carries positive mass,
  `μ([0,1]) = 1`;
* `mixtureMeasure_not_atomless`, `mixtureMeasure_not_purely_atomic_on_Icc` — the
  measure is neither atomless nor concentrated on its atoms;
* `vonNeumann_abelian_class_mixture` — **headline**: the `L∞` multiplication
  algebra over the mixture is unital, abelian, multiplicative, star-closed and
  faithful, i.e. the mixed class of the list is realized.

**Documented gap (unchanged).**  *Exhaustiveness* of the classification — that
every abelian von Neumann algebra is `*`-isomorphic to one of these models — is
not claimed; it needs von-Neumann-algebra machinery that is unavailable in this
toolchain.  What is proved is that the mixed item of the list is a genuine
abelian, faithful, star-closed operator algebra with both an atomic and a
diffuse component.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory ENNReal

namespace BookProof.ChapterAbelianMixture

/-- The **mixture measure**: Lebesgue measure on `[0,1]` (the diffuse part) plus
a Dirac mass at `2` (the atomic part). -/
def mixtureMeasure : Measure ℝ :=
  MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1) + Measure.dirac (2 : ℝ)

theorem mixtureMeasure_apply (s : Set ℝ) (hs : MeasurableSet s) :
    mixtureMeasure s
      = MeasureTheory.volume (s ∩ Set.Icc (0 : ℝ) 1) + Measure.dirac (2 : ℝ) s := by
  rw [mixtureMeasure, Measure.coe_add, Pi.add_apply, Measure.restrict_apply hs]

theorem mixtureMeasure_univ : mixtureMeasure Set.univ = 2 := by
  rw [mixtureMeasure_apply _ MeasurableSet.univ]
  simp only [Real.volume_Icc, Set.univ_inter, sub_zero, ENNReal.ofReal_one,
    Measure.dirac_apply, Set.indicator_of_mem (Set.mem_univ (2 : ℝ)), Pi.one_apply]
  exact one_add_one_eq_two

instance instIsFiniteMeasureMixture : IsFiniteMeasure mixtureMeasure :=
  ⟨by rw [mixtureMeasure_univ]; exact ENNReal.ofNat_lt_top⟩

/-! ## The atomic and the diffuse part -/

/-- **The atomic part.**  The point `2` is a genuine atom of the mixture. -/
theorem mixtureMeasure_atom : mixtureMeasure {(2 : ℝ)} = 1 := by
  rw [mixtureMeasure_apply _ (measurableSet_singleton _)]
  simp

/-- **The diffuse part.**  Every point of `[0,1]` is null for the mixture. -/
theorem mixtureMeasure_diffuse_point {x : ℝ} (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    mixtureMeasure {x} = 0 := by
  have hx2 : x ≠ 2 := by
    rcases hx with ⟨_, hx1⟩
    intro h; rw [h] at hx1; norm_num at hx1
  have hv : MeasureTheory.volume ({x} ∩ Set.Icc (0 : ℝ) 1) = 0 :=
    measure_mono_null Set.inter_subset_left (by simp)
  rw [mixtureMeasure_apply _ (measurableSet_singleton _), hv]
  simp [Ne.symm hx2]

/-- The diffuse part carries positive mass. -/
theorem mixtureMeasure_diffuse_mass : mixtureMeasure (Set.Icc (0 : ℝ) 1) = 1 := by
  rw [mixtureMeasure_apply _ measurableSet_Icc]
  have h2 : ((2 : ℝ)) ∉ Set.Icc (0 : ℝ) 1 := by norm_num
  simp [Real.volume_Icc, Measure.dirac_apply' _ measurableSet_Icc, h2]

/-- The mixture is **not** atomless: it has the atom `2`. -/
theorem mixtureMeasure_not_atomless : mixtureMeasure {(2 : ℝ)} ≠ 0 := by
  rw [mixtureMeasure_atom]; exact one_ne_zero

/-- The mixture is **not** purely atomic either: the null-point set `[0,1]`
carries mass `1`. -/
theorem mixtureMeasure_not_purely_atomic_on_Icc :
    0 < mixtureMeasure (Set.Icc (0 : ℝ) 1) ∧
      ∀ x ∈ Set.Icc (0 : ℝ) 1, mixtureMeasure {x} = 0 := by
  refine ⟨?_, fun x hx => mixtureMeasure_diffuse_point hx⟩
  rw [mixtureMeasure_diffuse_mass]
  exact zero_lt_one

/-! ## The mixed class of the classification -/

open BookProof.ChapterLinftyMultiplication

/-- **The mixed class is realized.**  Over the mixture measure — which has both a
nontrivial atomic part and a nontrivial diffuse part — the essentially bounded
functions act on `L²` by multiplication as a unital, abelian, multiplicative,
star-closed and faithful algebra of bounded operators. -/
theorem vonNeumann_abelian_class_mixture :
    (multOp (μ := mixtureMeasure) (fun _ : ℝ => (1 : ℂ)) memLp_top_one
        = ContinuousLinearMap.id ℂ (Lp ℂ 2 mixtureMeasure)) ∧
    (∀ (φ ψ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure) (hψ : MemLp ψ ⊤ mixtureMeasure),
      (multOp φ hφ).comp (multOp ψ hψ) = (multOp ψ hψ).comp (multOp φ hφ)) ∧
    (∀ (φ ψ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure) (hψ : MemLp ψ ⊤ mixtureMeasure),
      (multOp φ hφ).comp (multOp ψ hψ)
        = multOp (fun x => φ x * ψ x) (memLp_top_mul hφ hψ)) ∧
    (∀ (φ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure) (f g : Lp ℂ 2 mixtureMeasure),
      inner ℂ (multOp φ hφ f) g
        = inner ℂ f (multOp (fun x => (starRingEnd ℂ) (φ x)) (memLp_top_conj hφ) g)) ∧
    (∀ (φ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure), multOp φ hφ = 0 ↔ φ =ᵐ[mixtureMeasure] 0) :=
  vonNeumann_abelian_class_Linfty

end BookProof.ChapterAbelianMixture

end
