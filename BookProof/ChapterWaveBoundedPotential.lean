import Mathlib
import BookProof.ChapterStrichartzWave
import BookProof.ChapterKatoRellichDeficiency

/-!
# The wave operator with a bounded potential

Combining

* `BookProof.StrichartzWave.wave_essentiallySelfAdjoint` — essential self-adjointness of the
  free wave operator `□` on the Schwartz core of `L²(ℝ^{1+n})`, proved by the
  Fourier-multiplier argument, and
* `BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded` — the Kato–Rellich theorem for
  bounded symmetric perturbations, proved by an explicit Neumann series,

we obtain the Strichartz-type statement for the wave operator with a **potential**:

> For every real-valued, essentially bounded `V` on spacetime, the operator `□ + V` is
> essentially self-adjoint on the Schwartz core of `L²(ℝ^{1+n})`.

The potential enters as the multiplication operator `mulL2`, which is bounded on `L²` by
Hölder's inequality (`ContinuousLinearMap.holderL` with the exponent triple `(∞, 2, 2)`) and
symmetric exactly when the multiplier is real almost everywhere.
-/

namespace BookProof.StrichartzWave

open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

/-- Multiplication by an essentially bounded function, as a bounded operator on `L²`. -/
noncomputable def mulL2 (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure V)) :
    Lp ℂ 2 (volume : Measure V) →L[ℂ] Lp ℂ 2 (volume : Measure V) :=
  (ContinuousLinearMap.mul ℂ ℂ).holderL (volume : Measure V) (⊤ : ℝ≥0∞) 2 2 W

lemma mulL2_coeFn (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure V))
    (u : Lp ℂ 2 (volume : Measure V)) :
    (mulL2 W u : V → ℂ) =ᵐ[(volume : Measure V)] fun x => (W x) * (u x) :=
  ContinuousLinearMap.coeFn_holder _ _ _

/-- Multiplication by an (almost everywhere) real-valued bounded function is a symmetric
operator on `L²`. -/
lemma mulL2_symmetric (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure V))
    (hW : ∀ᵐ x ∂(volume : Measure V), (starRingEnd ℂ) (W x) = W x)
    (u w : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (mulL2 W u) w : ℂ) = inner ℂ u (mulL2 W w) := by
  rw [MeasureTheory.L2.inner_def, MeasureTheory.L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [mulL2_coeFn W u, mulL2_coeFn W w, hW] with x hx hy hreal
  rw [hx, hy]
  simp only [RCLike.inner_apply, map_mul, hreal]
  ring

/-- **The wave operator with a bounded real potential is essentially self-adjoint** on the
Schwartz core of `L²(ℝ^{1+n})`.  Here the potential is given by an essentially bounded
multiplier `W` which is real almost everywhere. -/
theorem wave_add_boundedPotential_essentiallySelfAdjoint (n : ℕ)
    (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure (SpaceTime n)))
    (hW : ∀ᵐ x ∂(volume : Measure (SpaceTime n)), (starRingEnd ℂ) (W x) = W x) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
      (opL2 (waveOp n 0) +
        ((mulL2 W).toLinearMap ∘ₗ (schwartzDomain (SpaceTime n)).subtype)) :=
  BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded _ (wave_symmetric n 0)
    (wave_essentiallySelfAdjoint n 0) (mulL2 W) (mulL2_symmetric W hW)

/-- The same statement for a real-valued function `W` on spacetime which is essentially
bounded: `□ + W` is essentially self-adjoint on the Schwartz core of `L²(ℝ^{1+n})`. -/
theorem wave_add_potential_essentiallySelfAdjoint (n : ℕ) (W : SpaceTime n → ℝ)
    (hW : MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure (SpaceTime n))) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
      (opL2 (waveOp n 0) +
        ((mulL2 (hW.toLp _)).toLinearMap ∘ₗ (schwartzDomain (SpaceTime n)).subtype)) := by
  refine wave_add_boundedPotential_essentiallySelfAdjoint n (hW.toLp _) ?_
  filter_upwards [hW.coeFn_toLp] with x hx
  rw [hx]
  simp

end BookProof.StrichartzWave
