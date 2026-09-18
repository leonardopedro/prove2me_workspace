-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.qgScalaronMode_symmetric
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

variable (M alpha : ℝ)

theorem BookProof.ScalaronEsa.qgScalaronMode_symmetric :
    SymmetricOn (mulSymbolDomain (qgModeSymbol a b (qgScalaronModePotential M alpha Rc phi)))
      (qgScalaronModeHamiltonian a b M alpha Rc phi) := by sorry
