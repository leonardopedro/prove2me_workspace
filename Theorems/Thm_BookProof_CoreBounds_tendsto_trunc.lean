-- Generated from ChapterCoreBoundsEsa.lean — theorem BookProof.CoreBounds.tendsto_trunc
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.CoreBounds

variable {ι : Type*} {c : ι → ℝ}



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section


theorem BookProof.CoreBounds.tendsto_trunc [DecidableEq ι] (c : ι → ℝ) (x : maxDom c) :
    Tendsto (fun S : Finset ι => ((trunc c x S : lpFiniteModes ι) : L2I ι)) atTop
      (𝓝 ((x : L2I ι))) := by sorry
