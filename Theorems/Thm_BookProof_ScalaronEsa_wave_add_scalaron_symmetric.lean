-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.wave_add_scalaron_symmetric
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_BookProof.ChapterClosureUniqueness

import Definitions.Def_BookProof.ChapterScalaronEsa

open BookProof.ScalaronEsa


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

theorem BookProof.ScalaronEsa.wave_add_scalaron_symmetric (n : ℕ) (M alpha : ℝ) (e : SpaceTime n) :
    SymmetricOn (ccDomain (SpaceTime n))
      (waveAddSmoothPotential n (fun x => starobinskyV M alpha (inner ℝ x e))
        (contDiff_scalaronAlong M alpha e)) := by sorry
