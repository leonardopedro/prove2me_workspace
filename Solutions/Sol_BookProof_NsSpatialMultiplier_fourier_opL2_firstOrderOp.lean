-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.fourier_opL2_firstOrderOp
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Theorems.Thm_BookProof_NsSpatialMultiplier_fourier_opL2_eq_mulSymbol
import Theorems.Thm_BookProof_NsSpatialMultiplier_hasTemperateGrowth_foSymbol
import Theorems.Thm_BookProof_FourierMultiplierEsa_fourier_firstOrderOp_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.NsSpatialMultiplier




open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa
open BookProof.FarisLavine
open BookProof.FourierMultiplierEsa
open BookProof.StrichartzWave

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]
variable (V) in

set_option maxHeartbeats 1000000 in

theorem solution (c : ι → ℝ) (w : ι → V) (f : 𝓢(V, ℂ)) :
    l2Fourier V (opL2 (firstOrderOp c w) (schwartzEquiv V f))
      = (mulSymbolOp (foSymbolFn c w) (𝓕 f)).toLp 2 (volume : Measure V) :=
  fourier_opL2_eq_mulSymbol _ _ (fourier_firstOrderOp_apply c w)
    (hasTemperateGrowth_foSymbol c w) f
