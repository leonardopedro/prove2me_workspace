-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.ccDomain_dense
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.ScalaronEsa


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

theorem BookProof.ScalaronEsa.ccDomain_dense : Dense ((ccDomain E : Submodule ℂ (Lp ℂ 2 (volume : Measure E))) :
    Set (Lp ℂ 2 (volume : Measure E))) := by sorry
