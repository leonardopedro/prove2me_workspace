-- Generated from ChapterNsSpatialMomentumMultiplier.lean — theorem BookProof.NsSpatialMultiplier.euclidean_foSymbolFn_add_fibre
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa
open BookProof.NsSpatialMultiplier



open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable (V) in

theorem BookProof.NsSpatialMultiplier.euclidean_foSymbolFn_add_fibre {n : ℕ} (c : ι → ℝ) (s : ι → Fin n) (j : Fin n)
    (hj : ∀ i, s i ≠ j) (x : EuclideanSpace ℝ (Fin n)) (t : ℝ) :
    foSymbolFn c (fun i => EuclideanSpace.single (s i) (1 : ℝ))
        (x + t • EuclideanSpace.single j (1 : ℝ))
      = foSymbolFn c (fun i => EuclideanSpace.single (s i) (1 : ℝ)) x := by sorry
