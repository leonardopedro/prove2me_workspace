-- Generated from ChapterStarobinskyPotential.lean — solution of BookProof.Starobinsky.confV_completed_square
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
open BookProof.Starobinsky












open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (halpha : alpha ≠ 0) (Rc : ℝ) :
    confV M alpha Rc = alpha * (Rc - M ^ 2 / (4 * alpha)) ^ 2 - M ^ 4 / (16 * alpha) := by

  simp only [confV]
  field_simp
  ring
