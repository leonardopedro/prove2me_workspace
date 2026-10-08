-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.memLp_conj
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum


open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]


theorem BookProof.NavierStokesFlow.FockContinuum.memLp_conj {μ : Measure X} {F : X → ℂ} (h : MemLp F 2 μ) :
    MemLp (fun x => (starRingEnd ℂ) (F x)) 2 μ := by sorry
