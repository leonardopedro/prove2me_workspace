-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.norm_hopT
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.ChapterA3n
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.FockQuadratic


open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ω : ι → ℝ}

theorem BookProof.FockQuadratic.norm_hopT (P Q : Idx ι) (x : Idx ι → ℂ) (b : Idx ι) :
    ‖hopT P Q x b‖ = amp P Q b * ‖x (tgt P Q b)‖ * ‖x b‖ := by sorry
