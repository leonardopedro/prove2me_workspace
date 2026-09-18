-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.scalaronFullPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_BookProof.ChapterClosureUniqueness

import Definitions.Def_BookProof.ChapterScalaronEsa
import Theorems.Thm_BookProof_ScalaronEsa_contDiff_scalaronFullPotential

open BookProof.ScalaronEsa


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

theorem BookProof.ScalaronEsa.scalaronFullPotential_essentiallySelfAdjoint (M alpha : ℝ) (eRc ephi : E) :
    EssentiallySelfAdjointOn (ccDomain E)
      (opCc (scalaronFullPotential M alpha eRc ephi)
        (contDiff_scalaronFullPotential M alpha eRc ephi)) := by sorry
