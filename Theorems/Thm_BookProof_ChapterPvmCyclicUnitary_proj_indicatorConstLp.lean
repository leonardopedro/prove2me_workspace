-- Generated from ChapterPvmCyclicUnitary.lean — theorem BookProof.ChapterPvmCyclicUnitary.proj_indicatorConstLp
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterPvmCyclicUnitary

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H) (ψ : H)
variable [CompleteSpace H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterMackeyQuasiInvariant

attribute [local instance] Lp.simpleFunc.module Lp.simpleFunc.normedSpace


theorem BookProof.ChapterPvmCyclicUnitary.proj_indicatorConstLp {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F) :
    proj (pvmMeasure P ψ) hE
        (indicatorConstLp 2 hF (measure_ne_top (pvmMeasure P ψ) F) (1 : ℂ))
      = indicatorConstLp 2 (hE.inter hF) (measure_ne_top (pvmMeasure P ψ) (E ∩ F)) (1 : ℂ) := by sorry
