-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.euclidean_foSymbolFn_add_fibre
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Theorems.Thm_BookProof_NsSpatialMultiplier_foSymbolFn_add_fibre
open BookProof.NsSpatialMultiplier




open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]
variable (V) in

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (c : ι → ℝ) (s : ι → Fin n) (j : Fin n)
    (hj : ∀ i, s i ≠ j) (x : EuclideanSpace ℝ (Fin n)) (t : ℝ) :
    foSymbolFn c (fun i => EuclideanSpace.single (s i) (1 : ℝ))
        (x + t • EuclideanSpace.single j (1 : ℝ))
      = foSymbolFn c (fun i => EuclideanSpace.single (s i) (1 : ℝ)) x := by

  refine foSymbolFn_add_fibre c _ x _ (fun i => ?_) t
  have h : j ≠ s i := fun hh => hj i hh.symm
  simp [EuclideanSpace.inner_single_left, EuclideanSpace.single_apply, h]
