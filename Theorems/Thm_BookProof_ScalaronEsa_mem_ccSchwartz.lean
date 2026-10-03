-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.mem_ccSchwartz
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section


def ccInclLM (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E] :
    ccSchwartz E →ₗ[ℂ] Lp ℂ 2 (volume : Measure E) := by sorry
