import Mathlib
import BookProof.ChapterContinuityUnitaryInfinite

/-!
# The Born law on a continuum: `P(B) = ∫_B |Ψ|²` is a probability *measure*

Source: the `ConditionalUnitary` chapter's *"A Less Arbitrary Construction"*
section (`Book/ConditionalUnitary.lean`) and proof plan appendix §E
(`Book/ProofPlans.lean`), whose *Boundary* paragraph defers "the analytic
integrability of `∫_B |Ψ₁|² dν`" to the finite/discretized level.

`BookProof.ChapterContinuityUnitary` recovers the conditional law as a *finite*
sum `∑_{z ∈ B} |Ψ_t z|²` on the cyclic lattice, and
`BookProof.ChapterContinuityUnitaryInfinite` upgrades it to a countable sum on
`ℓ²(ℤ)`.  This module removes the discretization altogether: on an arbitrary
measure space `(α, μ)` and for a state `Ψ ∈ L²(μ)`, the Born prescription

  `P(B) = ∫_B ‖Ψ x‖² dμ x`

is defined as a genuine *measure* (`bornMeasure`, the density measure
`μ.withDensity ‖Ψ ·‖ₑ²`), so countable additivity is automatic; it is a
*probability* measure exactly when `Ψ` is normalized
(`isProbabilityMeasure_bornMeasure`), and it is absolutely continuous with
respect to the background measure `μ` (`bornMeasure_absolutelyContinuous`) — no
mass appears where `μ` sees none.

The dynamical statement is the capstone `condProb_of_bounded_dynamics`: for a
*bounded self-adjoint* generator `H` on `L²(μ)` and the unitary group
`U t = exp (i t H)` (the same construction as in the two lattice chapters, via
`ChapterContinuityUnitaryInfinite.exp_smul_I_unitary`), the evolved state
`Ψ_t = U t Ψ` carries a Born law that is a probability measure on the continuum
for every time `t`, absolutely continuous with respect to `μ`.

What is *not* claimed: unbounded generators (the continuum Laplacian) still lie
outside the statement; that is the book's standing open layer.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory
open scoped ENNReal

namespace BookProof.ChapterBornMeasure

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

/-! ## The Born density and the Born measure -/

/-- The Born density `x ↦ |Ψ x|²` of a state `Ψ ∈ L²(μ)`, as an `ℝ≥0∞`-valued
function (so that the resulting measure needs no integrability side condition). -/
noncomputable def bornDensity (psi : Lp ℂ 2 μ) : α → ℝ≥0∞ := fun x => ‖(psi : α → ℂ) x‖ₑ ^ 2

/-- **The Born law of a state on a continuum**, as a measure:
`P(B) = ∫_B |Ψ x|² dμ x`.  Being a `Measure`, it is countably additive by
construction — the continuum counterpart of the finite additivity proved for the
lattice Born weights. -/
noncomputable def bornMeasure (psi : Lp ℂ 2 μ) : Measure α := μ.withDensity (bornDensity psi)

theorem bornMeasure_apply (psi : Lp ℂ 2 μ) {s : Set α} (hs : MeasurableSet s) :
    bornMeasure psi s = ∫⁻ x in s, ‖(psi : α → ℂ) x‖ₑ ^ 2 ∂μ := by
  rw [bornMeasure, withDensity_apply _ hs]
  rfl

/-- The Born law is absolutely continuous with respect to the background measure:
no probability is assigned to a `μ`-null set. -/
theorem bornMeasure_absolutelyContinuous (psi : Lp ℂ 2 μ) : bornMeasure psi ≪ μ :=
  withDensity_absolutelyContinuous _ _

/-- Countable additivity of the Born law, spelled out. -/
theorem bornMeasure_iUnion (psi : Lp ℂ 2 μ) {s : ℕ → Set α}
    (hs : ∀ n, MeasurableSet (s n)) (hd : Pairwise (Function.onFun Disjoint s)) :
    bornMeasure psi (⋃ n, s n) = ∑' n, bornMeasure psi (s n) :=
  measure_iUnion hd hs

/-! ## Normalization -/

/-- The total Born mass of a normalized state is `1`. -/
theorem lintegral_bornDensity (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    ∫⁻ x, ‖(psi : α → ℂ) x‖ₑ ^ 2 ∂μ = 1 := by
  have h := MeasureTheory.eLpNorm_eq_lintegral_rpow_enorm_toReal (μ := μ) (p := 2)
    (f := fun x => (psi : α → ℂ) x) (by norm_num) (by norm_num)
  have hne : eLpNorm (psi : α → ℂ) 2 μ ≠ ∞ := Lp.eLpNorm_ne_top psi
  have hnorm : (eLpNorm (psi : α → ℂ) 2 μ).toReal = 1 := by rw [← Lp.norm_def]; exact hpsi
  have heq : eLpNorm (psi : α → ℂ) 2 μ = 1 := by rwa [← ENNReal.toReal_eq_one_iff]
  rw [heq] at h
  norm_num at h
  have h2 := congrArg (fun x : ℝ≥0∞ => x ^ (2 : ℝ)) h
  simp only [ENNReal.one_rpow, ← ENNReal.rpow_natCast _ 2, ← ENNReal.rpow_mul] at h2
  norm_num at h2
  exact h2.symm

theorem bornMeasure_univ (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    bornMeasure psi Set.univ = 1 := by
  rw [bornMeasure_apply psi MeasurableSet.univ, Measure.restrict_univ,
    lintegral_bornDensity psi hpsi]

/-- **The Born law of a normalized state is a probability measure.** -/
theorem isProbabilityMeasure_bornMeasure (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    IsProbabilityMeasure (bornMeasure psi) :=
  ⟨bornMeasure_univ psi hpsi⟩

/-- A unitary (indeed any surjective linear isometry) of `L²(μ)` carries a
normalized state to a normalized state, hence a Born probability law to a Born
probability law. -/
theorem isProbabilityMeasure_bornMeasure_isometry (U : Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)
    (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) : IsProbabilityMeasure (bornMeasure (U psi)) :=
  isProbabilityMeasure_bornMeasure _ (by rw [U.norm_map, hpsi])

/-! ## The dynamical capstone -/

/-- The state evolved by the unitary group generated by a bounded self-adjoint
`H` on `L²(μ)`. -/
noncomputable def evolve (H : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) (t : ℝ) (psi : Lp ℂ 2 μ) : Lp ℂ 2 μ :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • H) psi

/-- The evolution preserves the `L²` norm. -/
theorem norm_evolve (H : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) (hH : IsSelfAdjoint H) (t : ℝ)
    (psi : Lp ℂ 2 μ) : ‖evolve H t psi‖ = ‖psi‖ :=
  BookProof.ChapterContinuityUnitaryInfinite.norm_of_unitary _
    (BookProof.ChapterContinuityUnitaryInfinite.exp_smul_I_unitary H hH t).1 psi

/-- **Capstone.**  For a bounded self-adjoint generator `H` on `L²(μ)` — the
continuum form of the Weyl-symmetrized continuity generator — and a normalized
initial state `Ψ`, the Born law of the evolved state `Ψ_t = e^{itH}Ψ` is, at
every time `t`, a genuine (countably additive) probability measure on the
continuum, absolutely continuous with respect to the background measure. -/
theorem condProb_of_bounded_dynamics (H : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) (hH : IsSelfAdjoint H)
    (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) (t : ℝ) :
    IsProbabilityMeasure (bornMeasure (evolve H t psi)) ∧
      bornMeasure (evolve H t psi) ≪ μ :=
  ⟨isProbabilityMeasure_bornMeasure _ (by rw [norm_evolve H hH t psi, hpsi]),
    bornMeasure_absolutelyContinuous _⟩

end BookProof.ChapterBornMeasure
