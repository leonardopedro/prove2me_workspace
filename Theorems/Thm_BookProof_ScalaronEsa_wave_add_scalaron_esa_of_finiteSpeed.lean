-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.wave_add_scalaron_esa_of_finiteSpeed
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.Starobinsky
open BookProof.StrichartzWave
open BookProof.ScalaronEsa


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]


theorem BookProof.ScalaronEsa.wave_add_scalaron_esa_of_finiteSpeed (n : ℕ) (M alpha : ℝ) (e : SpaceTime n)
    (finiteSpeed : ∀ z : ℂ, z.im ≠ 0 →
      DeficiencyTrivialAt (ccDomain (SpaceTime n))
        (waveAddSmoothPotential n (fun x => starobinskyV M alpha (inner ℝ x e))
          (contDiff_scalaronAlong M alpha e)) z) :
    EssentiallySelfAdjointOn (ccDomain (SpaceTime n))
      (waveAddSmoothPotential n (fun x => starobinskyV M alpha (inner ℝ x e))
        (contDiff_scalaronAlong M alpha e)) := by sorry
